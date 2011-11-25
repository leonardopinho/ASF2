// ActionScript file
package
{
	import asf.core.app.ASF;
	import asf.debug.ConsolePanel;
	import asf.log.Logger;
	
	import flash.external.ExternalInterface;

	/**
	 * Função útil que executa traces marcando sua origem. Por exemplo:
	 * 
	 * <pre>
	 * package utils
	 * {
	 * 		class Test
	 * 		{
	 * 			public function aMethod( ):void
	 * 			{
	 * 				log( "hello!" ); // output: [utils::Test].aMethod( hello );
	 * 			}
	 * 		}
	 * }
	 * 
	 * </pre> 
	 * 
	 * Bastante útil para substituir o trace e ter seu painel de console bem marcado.
	 * Internamente ela usa o stack de um erro para mapear de onde veio a chamada da função.
	 * <br/>
	 * Adicionalmente a log tenta executar o método console.log via ExternalInterface no Browser
	 */
	public function log( ... args ):void
	{
		var msg:String = Logger._trace( "", -1, args );
		var app:ASF;
		
		try
		{
			app = ASF.getActiveInstances( )[ 0 ];
		}
		catch( e:Error )
		{
			app = null;
		}
		
		if( app && app.params.debug == "true" && app.debugPanel )
		{
			( app.debugPanel.getPanel( ConsolePanel ) as ConsolePanel ).addLog( msg );
		}
		
		try
		{
			if( app && app.params.console != "false" )
			{
				ExternalInterface.call( "console.log", msg );
			}
		}
		catch( e:Error )
		{}
	}
}