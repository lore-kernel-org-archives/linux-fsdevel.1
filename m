Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.167.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793835384;
	b=3WruciHyhwtqMgimYps10s5Jjolyg9pZj8dH2l3n1cuF/5MyOUqyJ+dUJuvb8gUOSYTD
	 5OBhuC1/vkY7gGy50KWhiIl76pJUlL7wIjVbbWV29zhXjlNU5FD68DrSQPWp+7TnI1/Il
	 +rQyu64dWWzimJEB1sm7RLkIqadARFwHBeUCPFOvEzsdEamhiOCLBc7UBTPKiXHAkAazW
	 hpg+FBkziqrKjgQTGxConj2oD12eClyUXKTv0moOYaUv07Gufiig6JlLgW1eWn5stsnO2
	 WiMKpKQSUSG1nKeqW59JznH3neOTyoAMf845hX29hay3Zh1F8dagtwXZDnZUaAvU8Gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835384;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+LQC0duASj/wbky1DqYft6O4TD0nS/XTPwM2y5hSY3M=;
	b=2yu2GV/XBX5j+JMQX9IU+unlc1/2NXtrT27oFf5tvWi9HHTqp2Pp6GVx22JU11LKSZWn
	 H2t9D7rvcsbY+la8twnc7Z27dJ8zTC0iluxuHg9yCkcHdZyJP3A2c7cqC/x3NRAZbzHHT
	 WoPey8yNd+zOZ3KuC+vDTyl+cGQWgP6DxuT1w4raI7Qu1n2Dv76K03JxkruKAt+KgICfX
	 4xsxi1TaKv+pH3pEhIFIqxO8hmro09eBAUvzdD2hVSPYnlQNf3zIoKklrLALAwYp2a17x
	 j+TZICrLBEIVZcA/3xA6oEvYxr4Fz9ILmQnBu10uBgJP9kDiqXA7mTPYgDd9ZFV1u4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=gehtz.com;
	spf=pass smtp.mailfrom=gehtz.com;
	dkim=pass header.d=gehtz.onmicrosoft.com header.i=@gehtz.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-gehtz-onmicrosoft-com header.b=kKOvO22m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.167.92
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020092.outbound.protection.outlook.com [52.101.167.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84955606A326
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 23:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84955606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gehtz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehtz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gehtz.onmicrosoft.com header.i=@gehtz.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-gehtz-onmicrosoft-com header.b=kKOvO22m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ynw52psjrAvoq2lQrsdJGgH1nHenKxTJif5s6OiojQJJ7vHWBEYlqgc8tJYIBzd/QS8UXWUeHdkR7hI4TwySCOufJSiDHi4LHi7U5sgsx0fRsLLu6nEmVMELe+n9Gzn3viDT7jYT+walhd0rF4ZFZz5io1/W1+58qf6qHojrtGx/D0xJiWBD7z1YSvnfUGdF8bNnjSw68CdtShERgRUvIDXPRuXJ2MJ5W0ZzMRIWGsYTuiQkx3kWrXdEQuLXiE3SjQmJdx3m1e1NXg0a51eq1Up+Y2+DtrrhOsmBgIDY7nDHaFVR6t9KHCk/xLmFixuP68hSxMG6umxheQW7vRgw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LQC0duASj/wbky1DqYft6O4TD0nS/XTPwM2y5hSY3M=;
 b=MLQ3v7XY+2vMlCzoDHVHh+WOEKcdlAdhSxjztKoaTjhjl+9awC3aoSXGel5ab6PmfnYLtDEpIuUY4nxPcvPa3YGRn6h9hEX5MboQ5Irrm0A+Bxrs7xlmGJC0GQwXUdS94C9dQssIkmDIMeNoPyoyFcVWkD14WY6DvU/Io5ZXI7vF3BujVYdD1xTviUuqaBnRPbJs4AT1o/yoj72klmlpcmOaG3ET7S2Cbz6duuzqT7xz9L8UsZSE/yMhktJefro8dOvPJC0ryMC6TzlcKnQqS/t6yfXoMKJXqO+wQxo1JJaOFdyL+ybHmDz3u9gzMh7ieqikFlmYw8dyhEGWi/jGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gehtz.com; dmarc=pass action=none header.from=gehtz.com;
 dkim=pass header.d=gehtz.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehtz.onmicrosoft.com;
 s=selector1-gehtz-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LQC0duASj/wbky1DqYft6O4TD0nS/XTPwM2y5hSY3M=;
 b=kKOvO22m45VvGAXKzDuopoGGf2LQ8SRXc7W7oi7krnxCcakwwL5loHe5sR7kwWcpah+YxBaBRzvHbe4nEdZZLQR8+PD0RIy3X93wbmDhaCnoYQS/CAwQlMujEGjez9xlWTAAhbCT1x454tX3UXGVUhfa7+WfqHvXOQLlVedqU1a2xbxx1hudVCpMsPhG70TSBADGqZxLLtfdmVXYROY+WerSE4xrtBVhLlQb9EIKGbk9MX4mLh3Z0kA6g+DYFBS+0QxnF+4X6DXfZtVPnnQXk70Q+Rux/4Q0ZjssvJGJf7SyFDIj6sulmPNkOlEuE/LaeMlL3uZx2czTZDl+sCCAHQ==
Received: from PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:543::12)
 by MR1P264MB1953.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 23:36:17 +0000
Received: from PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1523:7b3f:c670:41d3]) by PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1523:7b3f:c670:41d3%4]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 23:36:17 +0000
From: Geoffrey HARTZ <geoffrey.hartz@gehtz.com>
To: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>
CC: "fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Joanne Koong
	<joannelkoong@gmail.com>, Brian Foster <bfoster@redhat.com>, lu gu
	<giveme.gulu@gmail.com>
Subject: Re: [BUG] fuse: auto_inval_data drops a write-through write's folio
 before its WRITE is answered, and a read caches the old bytes
Thread-Topic: [BUG] fuse: auto_inval_data drops a write-through write's folio
 before its WRITE is answered, and a read caches the old bytes
Thread-Index: AQHdbHtgKInjkaVtCkW7zRUk31/OObceP8GAgABRMZ4=
Date: Wed, 4 Nov 2026 23:36:17 +0000
Message-ID:
 <PAPP264MB7189471DBD020BE522C4139689682@PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM>
References:
 <PAPP264MB7189832597866399467B911689682@PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM>
 <4fd6eb6a-c115-4f44-bc48-f878716c9552@bsbernd.com>
In-Reply-To: <4fd6eb6a-c115-4f44-bc48-f878716c9552@bsbernd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gehtz.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAPP264MB7189:EE_|MR1P264MB1953:EE_
x-ms-office365-filtering-correlation-id: f09a8392-6d8d-46aa-f01e-08df3acc6c6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|23010399003|366016|1800799024|6133799003|10067099003|18002099003|22082099003|13003099007|38070700021|56012099006|4143699003|5023799004|261022075727099003|261022115727099003|261026140227099003|261028144727099003|261026121527099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003;
x-microsoft-antispam-message-info:
 RqSxMtZzlo75eKa4zg/w/JfvxK6Eo1k7yMQ9PAKGTDkdG+44I3nr/ud4cjeWBS3Kb5ceEtFNmxrONhs3DPJ3eetxEhm2FLXco22LOvx6nvwuoOj4mw5BKlv9tTWx+vF3EBDQhm6XUpH7xhfnZECkzsYEpFTy2PdEwmFaHFSMS4WPZeC61o4zwsaQPejFulKV1tLNzG9xT7Dos/oE9kj24G10uEQgUT9WRDvj57XvuwzMEuRL+lIKOEr7pUow2u2azjCF4/LuvOMkNMrZ8UbhgROh1JLf3mhAI1fIBVbcnz2wI+W8y9OJDMuA64OQPEFnCkRM6f2lbED7UVT1F5/WOiwwK89RgJuknKXFuo2AOcBfVC0a2URV9v+pnMjIAZWZspCj9OtepYqhX6ODYU5QaMERkIANUcLidtRzCSlv+n6tvDSnDy8jJZw0v/I0gKgLvDzRc6Qt00+176pFvcyVKmXGuc7enhckVBLuL/B4SAA1S97f3pf8p8Mjd+k0hDCYlRhL3IixFDPxq6G7iSWTBUJj+GATJ6JMPL5/GDfl2qN4EACmChvnm8AZkBnImb9ZDgYl0CfR8//iNmgPdLGC0mKHeljaEZgtfBE2sILU/vUMA49CVXK26oiH6lsBIlC5w+PyJFKKKNpBxy6aqPkqlHtUbwGMbo6mbskklQO/8bw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(13003099007)(38070700021)(56012099006)(4143699003)(5023799004)(261022075727099003)(261022115727099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KUne1hVPk6U8DcdOzFrj5tU5+zGJdqbZ/U13zCwJBEJ4/lBfJR6JFIeTbo?=
 =?iso-8859-1?Q?ElASZNMTXXxJOG5W//YLdkw1Kq4CJOTenxeun8ucBhooYi89bOsDoekftj?=
 =?iso-8859-1?Q?OnBe2y8zivmDVfh4dt2Yfmko0X5iNPU4RxhykG1iyadv1AHw7Mlp902rI9?=
 =?iso-8859-1?Q?6eCKHBwqk1xb+3pocZ69V7txaShsGLsJgVT9HHc2C83mnMa1VrInd+uc3B?=
 =?iso-8859-1?Q?JAkDNSHebo4lIrvzH2w6tFqA0jHrD9dLpnKTQ6UvWqLlJiLPJvF2aEzKZV?=
 =?iso-8859-1?Q?iMfheSK1pr2yDnj0lCi5r8VeKpmOeHlzxjWfCqaDG/wZGuY9jhfacLs6iE?=
 =?iso-8859-1?Q?8sJjNRNmX9UNla4amT2ybhGVz7l/oUD6nKHELkFJZ/YqGyw/aXCRubTZI3?=
 =?iso-8859-1?Q?973AwhLXCFUkrzA9iUbwRO+wUhH9vn1X1L7tx/2wyaabcTlJQ1sbasKsPo?=
 =?iso-8859-1?Q?xibUiY/ieP0dbHr3ixCR0xIf7mNHxUiaOovbR6ev5X07mv5Uo6pO8aw1B/?=
 =?iso-8859-1?Q?C0aaXXa/Xm8UuJfd+24XkrNcCWtj/+JJo0XCOtkrOyhlEuZ0/34nWDzuNi?=
 =?iso-8859-1?Q?w5a1A91gHJ+hWjhMpBRCb+clqFYct4STP/ERw6ZBJ0FsYQL+z1OXHUbLzC?=
 =?iso-8859-1?Q?Yx8W0iLjoEYUCZO8Fyj/WwzDbe35UuVKwW3fudeC5pMDAmh6rAFwTl+rZl?=
 =?iso-8859-1?Q?PHAvfGd3GAoUFrH8NnVydxMr0GJRyH5WKjW/hY3JQedhEbbs57WegLnVUt?=
 =?iso-8859-1?Q?dUDhyW1K4sAcvbTfyvILu4BL7PltB7PcZdJuHUovUUTRw5snLcMpV0grBI?=
 =?iso-8859-1?Q?VoNZJjSMPHq5njr3pTx7/1JVF0fz0CgD86Svgiw88Inhu8H+BNdBQG4hTi?=
 =?iso-8859-1?Q?8nKMqFbApjz8k8cJCJDTXvywnRzuIWFHnAVJdAlbTSix039nijDhkDYa6n?=
 =?iso-8859-1?Q?9dLicEkwmCWHsVdwgTkyNMMFOA/IpPlPxxdjQU5uC/qyfMosgvQn5Xjf/M?=
 =?iso-8859-1?Q?aWHiC7F5zJ9XMaC7ScGCzcww1vOaxwijfiVnU6aMTeieTQpkdSOUkb2KUR?=
 =?iso-8859-1?Q?6hdpYhNW/C3e+noE8W0dD6LegL2QDKY0s4A/Ylde09Jlawat5tBcbyCDlO?=
 =?iso-8859-1?Q?4ONTLpcw3CLMys7GjX/l27TZj2a9oFEw3gz+uAaWmne7wAmVJy8BERjmGh?=
 =?iso-8859-1?Q?w7XI95+H753tGlTkfgOSKcACapwYOmYpwQ4X0LqfM3RuX9fMFbdgwBzQCK?=
 =?iso-8859-1?Q?k79zzmET2pjz8BQq0JvI9u8fYsRSOg44aghr16GazlHqtCcBSbJyAcHGjY?=
 =?iso-8859-1?Q?56erZtThIJW1ahQ2saVKZxxeVdSewxfTkqpz1lfNIHYn6vuexQChVKF3Na?=
 =?iso-8859-1?Q?Y/lwzkV2njuc5mLqGPstTXo84IfZEkUXxRwRX4PAuOUOJg6w9Sm5JNkTsz?=
 =?iso-8859-1?Q?R2HyfSzeKHh6fjgnZGGuRF/XZK2OdffwgOEY95fAsWBfPpFgS4bBHGzGsf?=
 =?iso-8859-1?Q?ebNlte9Yfb6O8rAEzH+vKWFVWDzSUGBfow/1wEJzHv13ClgKEJmrgFMH4c?=
 =?iso-8859-1?Q?xcajSexpeG5FD8mUmsXnzsGnTH4zAqEHo9c3Pqxo74qk+pK+JvkJVj2qNZ?=
 =?iso-8859-1?Q?QUoYLOyl2xRnZwSdz/KL6IDqW21zIgHJV7kPIsOduzSyLg6mnzI4OdKO3S?=
 =?iso-8859-1?Q?/nd790kue0mbIAGW4GNF/YT+vU005lf9iavw2uHrKB3mSwq1uozfj3YrO+?=
 =?iso-8859-1?Q?U5QWptBgHIP8L6hVvBfU5xFwkR/uxMY3vkqQbC7/a54NC/MupIV3tkEx1+?=
 =?iso-8859-1?Q?6223Wmo4TESRmA4IJqhAm2vNTYA4FjnVsp/+7pdaxB9z7PlufYVbQDVYgk?=
 =?iso-8859-1?Q?BA?=
x-ms-exchange-antispam-messagedata-1: FlAZaK4q/oNBVQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: gehtz.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f09a8392-6d8d-46aa-f01e-08df3acc6c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 23:36:17.6586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75a5ff28-5974-4bc2-8890-738005ef36cf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TOOJaFaN1hqOhuG6sHA2DaYhQet5etfnnBYL2zXnYQHTOMoJRsEsonPRuJYHcDdZKpBbRfnjOYt28H3o93/KSOQ9Y+jTwYz+N+AwIjJMfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1953

On 11/4/26 19:43, Bernd Schubert wrote:=0A=
> https://github.com/libfuse/libfuse/commit/b3f0fac436931223bf67f4484e8fede=
2ab2eecef=0A=
>=0A=
> which references=0A=
>=0A=
> https://lore.kernel.org/r/20251009110623.3115511-1-giveme.gulu@gmail.com=
=0A=
=0A=
Thanks for the pointers, I had missed that thread. Adding Joanne, Brian=0A=
and Guangming from it.=0A=
=0A=
What may still be useful:=0A=
=0A=
- No fix was merged: 7.4-rc1 still unlocks the uptodate folios before=0A=
  FUSE_WRITE is sent. Miklos's v2 test patch from that thread=0A=
  (fuse-write-through-set-writeback-v2.patch, 15 Oct 2025) still=0A=
  applies to 7.4-rc1.=0A=
=0A=
- The libfuse change covers servers built with FUSE_USE_VERSION >=3D 319,=
=0A=
  once 3.19 is out. Servers built for an older API version keep=0A=
  auto_inval_data on, and go-fuse asks for it by default as well=0A=
  (unless ExplicitDataCacheControl is set; checked in v2.12.1).=0A=
=0A=
- Our reproducer hits the race within seconds, and SQLite in WAL mode=0A=
  on top of it corrupts a database (page 1 overwritten by an old WAL=0A=
  frame).=0A=
=0A=
Miklos, is marking the folios writeback still the way you want to fix=0A=
it? I can run our reproducer and the SQLite test on 7.4-rc1 with your=0A=
v2 patch, or any other candidate, and report the results. I can also=0A=
send the reproducer.=0A=
=0A=
Thanks,=0A=
Geoffrey=0A=
=0A=
________________________________________=0A=
From: Bernd Schubert <bernd@bsbernd.com>=0A=
Sent: Wednesday, November 4, 2026 19:43=0A=
To: Geoffrey HARTZ <geoffrey.hartz@gehtz.com>; Miklos Szeredi <miklos@szere=
di.hu>=0A=
Cc: fuse-devel@lists.linux.dev <fuse-devel@lists.linux.dev>; linux-fsdevel@=
vger.kernel.org <linux-fsdevel@vger.kernel.org>=0A=
Subject: Re: [BUG] fuse: auto_inval_data drops a write-through write's foli=
o before its WRITE is answered, and a read caches the old bytes=0A=
=A0=0A=
=0A=
=0A=
On 11/4/26 17:50, Geoffrey HARTZ wrote:=0A=
> Hello,=0A=
>=0A=
> On a FUSE mount with FOPEN_KEEP_CACHE, without writeback_cache, and with=
=0A=
> FUSE_AUTO_INVAL_DATA (libfuse's default), an in-place write(2) can leave =
the=0A=
=0A=
https://github.com/libfuse/libfuse/commit/b3f0fac436931223bf67f4484e8fede2a=
b2eecef=0A=
=0A=
which references=0A=
=0A=
https://lore.kernel.org/r/20251009110623.3115511-1-giveme.gulu@gmail.com=0A=
=0A=
=0A=
Thanks,=0A=
Bernd=0A=
=0A=
> page cache holding the bytes from before the write. Reads keep returning =
the=0A=
> old bytes after write(2) returned and after the server stored the new one=
s.=0A=
> In our case SQLite in WAL mode read back stale WAL frames, and a checkpoi=
nt=0A=
> copied one of them over page 1 of a database (Plex's library).=0A=
>=0A=
> Reproduced on vanilla 7.4-rc1 (not tainted, in a KVM guest), on Debian's=
=0A=
> 6.12.111 and on 7.2.11. The code involved is the same in 6.18.=0A=
>=0A=
> The sequence:=0A=
>=0A=
> 1. Thread A calls write(2) over cached pages. fuse_perform_write() calls=
=0A=
>=A0=A0=A0 fuse_fill_write_pages(), which copies the data into the folios. =
Folios=0A=
>=A0=A0=A0 that are uptodate are unlocked right away ("if (folio_test_uptod=
ate(folio))=0A=
>=A0=A0=A0 folio_unlock(folio)"). fuse_send_write_pages() then sends FUSE_W=
RITE and=0A=
>=A0=A0=A0 waits for the answer. FUSE_I_SIZE_UNSTABLE is set only for a wri=
te that=0A=
>=A0=A0=A0 extends the file.=0A=
>=0A=
> 2. Thread B calls read(2). With auto_inval_data, fuse_cache_read_iter() c=
alls=0A=
>=A0=A0=A0 fuse_update_attributes() on every read, and the attributes are s=
tale=0A=
>=A0=A0=A0 since the previous write's answer. The FUSE_GETATTR answer has a=
 new=0A=
>=A0=A0=A0 mtime: the server moved it, for example at an fsync of earlier w=
rites.=0A=
>=A0=A0=A0 In fuse_change_attributes_i(), fi->attr_version has not moved ye=
t (A's=0A=
>=A0=A0=A0 answer has not come), so the answer is applied. The mtime differ=
s, so=0A=
>=A0=A0=A0 invalidate_inode_pages2() runs. It removes the folio A just fill=
ed: the=0A=
>=A0=A0=A0 folio is unlocked and clean, and A's reference does not keep it =
in the=0A=
>=A0=A0=A0 mapping.=0A=
>=0A=
> 3. B's read finds no folio and sends FUSE_READ. The server has not applie=
d=0A=
>=A0=A0=A0 A's WRITE yet, so it returns the old bytes, and they are cached.=
=0A=
>=0A=
> 4. A's WRITE is answered. Nothing drops the stale folio again: the mtime=
=0A=
>=A0=A0=A0 does not move until the server's next change, so every read unti=
l then=0A=
>=A0=A0=A0 returns the old bytes. This includes A reading back what it wrot=
e.=0A=
>=0A=
> writeback_cache avoids it (the folios are dirty, not invalidated). Withou=
t=0A=
> auto_inval_data, only a size change invalidates, and with=0A=
> explicit_inval_data only truncate_pagecache() runs.=0A=
>=0A=
> Reproducer: a small go-fuse server with one 1 MiB file. It applies each=
=0A=
> WRITE 3 ms after it arrives, and moves the mtime every 20 ms when writes=
=0A=
> have landed since (a periodic sync, as our server does). Writers rewrite=
=0A=
> 1048-byte records in place and read each one back after write(2) returns;=
=0A=
> readers read the file in a loop. On vanilla 7.4-rc1 (16 vCPUs), in 15 s,=
=0A=
> 441 to 461 of about 4,440 read-backs returned the previous record, in eac=
h=0A=
> of 3 runs. With auto_inval_data off: 0 in 3 runs. SQLite in WAL mode=0A=
> (1 writer, 3 readers) over a loopback server built the same way (WRITEs=
=0A=
> held 3 ms, the mtime moved at fsync, close, setattr or every 30 s): 2 of =
3=0A=
> runs failed within 9 s ("database disk image is malformed", "file is not =
a=0A=
> database"); with auto_inval_data off, 3 of 3 runs were clean. I can send=
=0A=
> the reproducer.=0A=
>=0A=
> Possible fixes:=0A=
>=0A=
> - Keep every folio of a write-through write locked until its FUSE_WRITE i=
s=0A=
>=A0=A0 answered, as is already done for a last folio that is not uptodate=
=0A=
>=A0=A0 (ia->write.folio_locked). invalidate_inode_pages2() then waits for =
the=0A=
>=A0=A0 write.=0A=
> - Or make fuse_change_attributes_i() discard an answer (as it does under=
=0A=
>=A0=A0 FUSE_I_SIZE_UNSTABLE) while a write-through write is in flight on t=
he=0A=
>=A0=A0 inode, not only one that extends it.=0A=
>=0A=
> Our workaround in the server: turn auto_inval_data off, set=0A=
> explicit_inval_data, and invalidate a file's pages ourselves=0A=
> (FUSE_NOTIFY_INVAL_INODE, or an open without FOPEN_KEEP_CACHE) only when =
no=0A=
> write open of the file exists on the mount.=0A=
>=0A=
> Thanks,=0A=
> Geoffrey Hartz=0A=
