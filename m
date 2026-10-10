Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62591364E98;
	Sat, 10 Oct 2026 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791650939; cv=none; b=afVU2pRocTX2QYDEeYXfdC38JNYQhQfT3F3wOHLalOlQcrlBm7yI3TyT43J2Ms/eHruSpLnWJNYyDZl9iP9LENKc0kLcenBbF2v5Hb5QS8v89YZXozfoalRqvhMAkc/MCpNpOk6GK4PmG83MDfHIl13irAMlGWJ6ALDuXoMSLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791650939; c=relaxed/simple;
	bh=i1CYNe0vdFyiO0sA5yLDdFFnvdW6r/nWyNkj6NoroNA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hFlRwbWXzjipqCH8G/vfDS2+9NEecc17IjjnMjbKt+o0ugczdQov0yvvwPeqWGAbwpGrv7bzCoO5TiQiFCeqZvk7aPuq+189zDd0t5Ucg3Lfr/XoPbwpu7W5qVSp2gf1vPq3yf85vnBoKP92f+KWplM2gn93kLrOrEdurKlV19o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CQOshMVY; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CQOshMVY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791650910; x=1792255710; i=markus.elfring@web.de;
	bh=7Ee9Y9OwWV7r4q6G1DQBCrlPWkA60E3ONaN9TW0EpOU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CQOshMVYNBN8r0EoJqnjt6RiDaRP7yTCIpmdhoSHSyDfxUkt4cgx7Ak6g1Zhd6EH
	 7iHtbpN/DYHPqHYxTwESdR2qJgsdF8e3GAbx+00MNhtO1Y+73jPTsULEg1HAEnAGo
	 48DeKImH+V/LeccGOHoYdoQx62U6VSoQQ2B7nQiyDN+eEAJq8EakB7YXd4sOm6NRA
	 WnTX0ups2zUhtsLNhqDXEuWdiI7j0mYkWp1mZ5y0Uyi1l8YUtq9nsu8zB+it0WsTX
	 7qLMIjvHNsqPq1tKqpG41r8A+rE6GXvIF40J1f83cbKPnY1EhjMjH1UM/SkkXEvq3
	 TWct7nKPumcKAn46sQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgANG-1wjHQO0a8U-00bFcW; Sat, 10
 Oct 2026 18:48:30 +0200
Message-ID: <57a2ddd8-0414-40de-b037-449cb2b5798e@web.de>
Date: Sat, 10 Oct 2026 18:48:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Dave Chinner
 <dchinner@redhat.com>, Glauber Costa <glommer@openvz.org>,
 Nikolaos Karaolidis <nick@karaolidis.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fs: Use common code in inode_lru_isolate()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nh3mOUluHF6DSW0rYqNgXU9aUsRagbDWH6Tpw1KRYJz0r/sscAa
 sjS6MN9QtOM+2H1+7ukrOBvs4ByG4ZNdPySDxxD8EiKOfhSv3Osz90ZV/cNwsHtQxvPXv1M
 4Sgk2lk8aMf4CcDA3c5mabVU7JQIV2+/oTUe2eosO1FohW98ROpgT2wAgfNSNPorxic00L6
 tMEvfFOxn6sTBWLWImMMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ULM9vK0bogs=;HH3H4V7mcoPsu0A/tbnm2XZrSOw
 zMs9tTYfhktWHu7lWvWNJWpElShdsJC2Yh4/w+BujCu1cpbyCEh7w4M3uIaks/0DEExzGXZ6x
 5yHZFW84XstpdWfhItOeOkzlX50TMjJW7lYN4FrvJsRMwUIj3lN/5u6hDSGfMwl6LMNEsLCgW
 rUgogoOJmoL/9w0Y19owGhxkh6bo0SJNQomd8yg0vX3D3yGn8wcOdhxIKpCfq9OrglFPftc2Q
 KOlLg6Rcp8FekK7IkPF/yZvJ9YGlWVNR57bBcjS4TUTseDz5dGpbcFGdTjEVT8cK8U2x2AHDb
 Ex2vGWLCJDSDVg7evaZZLjrz8UxH1M0hvrN1m3KGR8Ewqsx8KG9z2M2dkjkGNOeg/LNBZHmcl
 YDsV++wSVqMr7NAB/r14V6KTN9waHyfGhefZdE5/BY07S31n33RyQgbD+vjcjeLidSGpNuLsM
 13P/j4aGmnNtadIp7BaaMzV9mJxNEf47ZzwtFsIMSBTkZqHLmLm+IgXligq8Hc4pgZpGYy7pe
 GHC3FqNzUhUzunvEC9qI1k8MdJxFeO/DVtlFB839KCndCS2HxQE3Up33oBaXzg5Rn+bGtB2vA
 UvsUVtXBSgxgQNzdQ5UMd4HKei3uNrujldKF6RA3+b2bduRM+1Pbcsj6wSnaKV9KkFiF0znUk
 0gbacDdXXuG5Vwr2CNxitIyP/P+JuabV0WdVS/x/PU1UGiV8aOVx7Hmz+sq9BZdORdYfNyczj
 rPrTzptVxPjbfja6+LG3GAU2wB81nMf1vYNUgVX6RY9FvlnjGNJXVlfSvmCyveC+5TiRGJMUo
 DI38/b01c2U/YdKpRJXmW6bjHdRLUt3A3uJlabTWhWWYwTW2P9x90amWOz1xVE51GpKEfGeK1
 zvkkB42Pcd2qdrxRO2Q3P/e86IWLOpJOnvdNytoyQ48NgyI1GZqyJ3Lr8SiNAX2aMEOo8r1tg
 ch6E9AdU5uf5ybopa3vLrsTrvOb7mBibbHEH7BB++bEmZ2/V2Pp963gq/g26xosKJU4XG9wJO
 QfSc8t8ulWSN3CVRomFt9Do02sVhSQ9QRy0sAnXgd/IA/g8X0RHu5DrOrWO5own/fjNeGSpKl
 9IV2meCX45Dc/O6ah7AIkZ5zWYk29+xnPQ6lRfG4vR112aTgM9ajRciYjggnefQ63kvzh6KnT
 aTX3T6L5UyOkBbtNHXRxxuQmU8ChjojE8YqN7hV+Je5F3wc1aiJsEgCVWecmLe3pQlJB9fawx
 nVSBj7BOG/lxqenosdAu6C06rdRgHSUR8sTPhqlngSmF2MnNSz4uimw0E9u2Odu9AQppLCBSo
 aPr8hvrMpp9zR254QPhEXRI2uIsI5tih/WCNXNEPIsVra/r5fvgvqFTG/Ft0GVZdQ2e8bBNsW
 wJ3MllUkpZ74PNa9OSCs9ysaL6XfR/LWxK+SoYHQ5wYqe2yuK58S7Nj1QcaD65MiI/ntAxkV5
 q/wzq10yYI29npVFyBPUNRbI0+QkrE3c0CYMlmwUJYKMXFk75Rh8I5n53p4ue2Ni/OL99Aa3F
 YtSYYYjJPpUY44JW8BUunaKTBvkNomBRXcS8r70jrvH2WUCuig2ZcKEGESEDC9hSZQPDNxlXj
 sLGYY4UzeGlaqf0OUOB0rXQizcvWszhWDrv4VQ3aMTtpdB8pcEkVujKY537OcszkaIuLPfDsM
 wZlKlfAfxKuGWyYnUq8ARPnVKMFKfkSWMxJE2/o0JL25gbhyTWNkERnhEH4CpmuDELFABSdVL
 WKtj3jyUicwHRaRFOaEDtCXn14ODyruKKpc9oF4KvaRlKG6bL4PN9RizkGDL0wqEV04DaZnr3
 UM/Q3JtNafdoZpDwAyuhQJIfkGqpcNQ1EY/dRrQ1M0HuPO0Oeb6GwED7KLrGqN28xFMjXfUTb
 YGfPqjelnKkvDORlthlfDRbcGOxUisiauS/ZoIclY04VYKRbi1b9EccW4ZRexBQG22Iu/zHPW
 f2g/tH6jMRXTEwaU1SXqsxn+O4wAgiVGYV/od4fhePHvI6B1XOanV60C0KZkFESV/4C67LITb
 ZOvywqiVjz4ESbB7w1bbREuPxtMiwX52joeLoGuAjCin7hoiMw6WCxwTIMf45XHC33sIeuxym
 jaNg5L0FNmnz3nGpFps+jEnZ6l94JaeQ0dciZSFJOQIDhvsiNAGKLWlFjpxfFSLCQI4bvATl9
 PrRbq5CjB+pYJ1Y15o24VfXRH3cVf7s4F8cBHcm1cC34vXOr79UBaTnpEcgbPZtHeK91JWR14
 rXnRIJN1fuXBc41S0CDBdReaaC7pB4M9fcusc97Dg4MQjPe/psqZfpjaJdyu4fyIFGPPCtLUY
 MNy82VZnX5UIuJuOgWNrkFg1Vq+yhkc6OMBZ/COgfVVgutOkJdjdrsj/M2lTxm0TSyEVXVTBw
 k2egiPfX9OH1AOIRuKjz07LwrQtTW4pBZ5VzLwxSyR3YuX9jXfT8aEVBnZ/hkSMNQQRe+ZBsT
 g89YbN8XL5aV7AB9qPs7kq+WJvIQv2htxF0/OhRmIgXNG7tj/qWIvpz644+j/aCYqnY85Sks/
 xBZL2GMWtI7bVOySxR63S+egXio0D7+E2ynPBXKK/IIU3k6zInlrGzjCQZkHzyiBiw4XbotNU
 RTZtwYRER1lKr8xqGjFgkAoXzG2hVhp9LqDBNN3Yc7bNNTD/vnwNgw33pzZhFHam9AmlnUBpR
 cw4aOkQcYSMbIO1wVLvVWc7XM9FOGCoEDD/QJEQURyGv8DSFIcsoVe2HhDutIwGykXTsnA/69
 Znih2xFSCy562NyzD/O0dtCho+H+Fgj4nfIZad2hHGO3QADyn+VFaFcEueRZfs6r2frjT+xOv
 9W0/sv9smwbmPA5y7PKsBKmAnO/FT2c1lWvS1VHdLqQDwqz68c3kTtBCVzJ8jr9XLE0wmAFX4
 aaQAyzgasz0JpsCh2CL/UJlcmCNIczZDnHa6FoVUysEdNq3CmOLx2TkuQwoXeDN7rKxUF+/AD
 rtu5HmyDQgBs7g1jZgxDYEWb8xsnoUu0ju+b4B09+LXqFqHjSKYTlxRJ24HmmgBPU00jcp0IM
 fGSWGgfFT1rW1LNgBFMXYBqRc290gWb84H8MqTqB6MIEMHfTTBooW36hvF60yAoqgDv50c3ZU
 ejpBURmaKtUMo3aW8hGtGm3ZzjV+p2LymyJ6KL+rDgjTMBonSc2//E/u/MrQplWCzWvpB1wFS
 WKaefuM5RsIo6v8yiSUSfFt5vRO50qbCHNBIFE/QDfSaAMA5EaDfAEI5Pf5FH0eSAHHGcKanK
 DRRUTNqAVZ4H9AtBkMtbFgINUlenl4WxoqdANViLLK8DNUGopLA+6g9Ysk2/LukH4FgS+rsvS
 8HlQAM2aMMg9jaqQnC+/wq+EBuuN8YCK7vI/UU/DjiKc7MKk+lH1/PJE+1NKuHEX8EqRtyx/5
 6oLd/flAk7yhdhgwQTMEaBNB0lsBkyRzo63zcn/pNy4WmtduGtuL3lww7sk49pYbUtWwVD9ks
 PTKTOfaSQ0kwkCYkzsHSA2EvF+DpaTO2JHcpIh4AnJoUsyvXi3WFEjl2SFXj5cAlEEi4olmtI
 kxlvqTTV6QaB2xXyQe82U/r9ro2yDhQGTy6bbu6rxEiBltitMbFQKcyHjXN9atKU2rPisUUEp
 hXVlkaCESy8l7qrnDEu59hdGuOLiB5yWm9X61lQPB2mbc1GabLbfDveqotbNLxpLB7kdjdXSB
 vB0FU2ouKVE3l5I32qfyc1a7472oultMQuKwv1fiwZvO9kljXvkaflDL11g6bqpmezFQ0OGTg
 9FpWEzdcXTUZ+jYTs62nNHMsmhWNUsgPiFoFiRlGjnYFLHCLad8iDb//QP1g1JfUxpyGYy7Uf
 pxDoaw19Tf0kx6iyKuhabYTpTST5tErYV5VfUZ1hJJyMHxhZvKLqw6kInmPSne5ZIoLOMn2un
 H/9IgJpe0PZYht4EahLHhwyrSiUCwSjWIXTC8sMAx/tFq4MemRbJH1RNIifeChJS3M17Slhj8
 ZurKs+VBxduyBv7LFHeuGzTyqAf2G0qpJWMesjjY5vHQQ3yoXz7ZMXmnHiYHaQaoomcehoi3f
 LcgfMBgYwIevzn6Ao0eREfnHc6MfMmL4P2NcrZP82QrWbLfO1EGjSeywn8R8RtWCXZYQSI4B0
 qoQJMZhVFwyvsymZ4C3LCCF0jnNSrvyuoAchH1coq4Raqi3bFC4wwg6qfCCxvpu6uXOpVm4dl
 Q+keLLOnsWiL7TRcbvxMXn3/V+t+JPygcPLN3tKNBy3taWJHDTWJ/r0dECx+85E/BGYIENC+0
 cRDraLjpqQwFXcF4ILcNFO3cgE/bb/hd4H4OMyfGQQLRwe5i5Xo42MuLy8EGHZw/Ae/aubP8n
 jC82DWmInWBn8RQ8oY+oSCB1E/nmGUyufB6gHALJz9+ums91lIRHBIKdhgNUEWiVioKetiaYa
 zBNFCF+s4frCOFQ/j5qwqj49Zdyq8I0otdpnd/Y49p6NTHPi8DDr09/WgxHxYHdOnkxixEwex
 tTHpY+QVtu9JGH2DY5GmoCO8WQyvthy2pSvMrsF6O3j+ERTzGHMAwoF/u284aeofe5kCmCZW1
 o1ezW4DJNCshQ076SXYxT0uzHqW0krmf81Ljmim2ASsmnuZNH0k7CEWBFLIcGksGhUoulHTeU
 GquHAm/nmA2pABdYm1FdmGOf7jkvLxFG/gyZNRuakdhGZswWmg/QHWcXPNIBK8qRFmpUSh2br
 Hzlx7Qb+ceirESHdUD2XUjKbsrwPlSanYfqRXbBdk1hTy/4fvs15ie45SQ9b/arCkAn/Sdkf9
 ikOwer8j/maRjhUoZBPgikbdUZsWF7Apeua8r4CV1orVxZY9pRDaUEU1SxwQZsz9e+qwLIWkg
 SxPrbXyiyxnEf4PBvUMtUcX+MWOhZVH0uH7AjhEhFZM8rlzKNFvnigQy1YRCDQUD2RPy/xpwU
 K67Deed5ruvJDuhjTOB1V4lBYuxpBeNtc4/hEzcHT4DvACbzr8okm7JCrFXbUSYNB1uFIYZfa
 mzhLb0O0Brt3h9clVcVYF8VtPHGyGQQsDyRKdkvWjrMv2VpYI/2vt8sdqvOJnflrjlD5YSqpP
 0UKvQhRnuoY/i1vrrxlt3f8KHDO7kC9jESJtDNSZZrD2waBWbhlAVVvr2Rvkan26W54+Wg0wn
 W26DMOmv2o+9nMfXp4V3RMDaHq0Iz2LLklVrMmgoVffZCW+wHOSdkZBV1N91yis+Odq9OWSgs
 MLRqJOxGW9mgTdzreiccSbFDgjpXDYD5maI/OkfyvlMUtiBzKfPksFxUYXpMotKjupZSrCpEz
 fI5dVDpN/6Z1YVPomg9LoyhyJCqK5MZA4heVXlPFu8WRFRDltmu9ku93ywMvyWTKUDsWFfhdh
 SMu0XrouzmjMNI/Jj5Jjz0uicKGN9cyZXXLigOQGkf0i0LqsclfaayR0cSBt/4PIOxmDbPStA
 r8gLiBKa/i14bHKX53AjccIeDCdtFY5QsxIhUsQFe68AcrsAwhx1C28ozMiehM6lfSiyQQc5x
 W8acpszT4aseyE/kIMirt07rAJnPofzsYs+M1O1LugGos/l01oRJq0PnnJGOnJrvHBPTMItg6
 fyHqfUJzc4mnDOx+SutiN/9uwjRHqmjiH4hOp9f6A5Xa7yOvvl9waJSqR/JtYbnHaGLc+sWcQ
 VjOxzOPfB0/SjfGt+T7+dSl9KKkPwn+nkTzUwx1a+DC9itbcQvdfYpueFaLnPOJ6tm+cnYZYx
 kaEqJSeVfsYbGHZ4HjE1lVDVB0w8mqSQpFcWQlaKuBb+SANlgheY0j6WJBb8iDMv+5TGu1ue5
 Bw5fUY+N/FxIloIoywdrIMWDv4V4NrBUbW6w3dKhWT0hrUfDv92aL9WH6kHesSmGylub5e+UQ
 dlrD3YlckS9jj+sZXRoopSDx+198CtFeJ1WJsdstHbRcP7L/PB+kWKnrAolBwGPzGw4sgncP/
 PD+5cJFZDuI/4NH1z/k8/5cWUr+GofaV7SkfPN+Soc24CMyAquro6v2fKNhfnWZK4dobPY/zn
 sJrcYD2Q+QGugaKjCHDnTH3GuapdS8cEuxxngxyonbnIm3K0hZltjnFCZOqQ5NL8hb36U4jVA
 DOobAtIJOFy4qIYaDiQHTh7Y9rtTpLcUNWuzo3Qj8LVTO1S1opbozg/YJy0ALQYySCoAhsuIo
 Qf0VpRYy/Yh+J+/oLfiVI9u/UdHCUJW3XWkE7EN+wzwJrlAh36lDJFnBrHXldvDSGEjTb1Ytt
 ROQA55d+FaQUliB8KQSRwylLE4gJxLTyRXVn992PUlq5uVMBtL8APbKnrIuqaFRRsH5RsL2Fj
 JZ747nl9O0is387HGECf3SqA9QcERUTTh0NSDVt9qwKVnviQ7vOADODxMZ40ddHg3XfLrDg2K
 78Fa2sgJdCVFJpc4Qp5UcXsWf3N7TVxLSH/+Xp5oDTRNTr3eO2LhAk/+iPWOJi1mQvXL6BBwh
 ymll94rXY1smoNddqC21Oy4KBaskWOQm9aOtJnahsUQGuUMLnf8VIy8gfg1squ03Nf0C36Wd2
 vQf8+cvHw48672huw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Oct 2026 18:33:37 +0200

Use an additional label so that a few statements can be better reused
at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 702f2d5ef459..3cac85bf5ec3 100644
=2D-- a/fs/inode.c
+++ b/fs/inode.c
@@ -953,9 +953,7 @@ static enum lru_status inode_lru_isolate(struct list_h=
ead *item,
 	    (inode_state_read(inode) & ~I_REFERENCED) ||
 	    !mapping_shrinkable(&inode->i_data)) {
 		list_lru_isolate(lru, &inode->i_lru);
-		spin_unlock(&inode->i_lock);
-		this_cpu_dec(nr_unused);
-		return LRU_REMOVED;
+		goto unlock;
 	}
=20
 	/* Recently referenced inodes get one more pass */
@@ -989,6 +987,7 @@ static enum lru_status inode_lru_isolate(struct list_h=
ead *item,
 	WARN_ON(inode_state_read(inode) & I_NEW);
 	inode_state_set(inode, I_FREEING);
 	list_lru_isolate_move(lru, &inode->i_lru, freeable);
+unlock:
 	spin_unlock(&inode->i_lock);
=20
 	this_cpu_dec(nr_unused);
=2D-=20
2.56.0

