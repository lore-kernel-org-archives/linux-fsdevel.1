Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=40.107.160.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793811039;
	b=Pm2kABgAQSjS+STlcgM91IednPYWQaH4LCr4WiuNYGw4KcCDY7BuscJUTuVRWyo35C1q
	 8bzRAal5bZtxhcX9EA6cw4bmm5ZR3x1lrrUQh8TGVRRYlITmnL4ht9xewiBIlaRiwjiwn
	 KcJLVI/8fhnUE8TVobVUyjp0TggR2lM2wxPS4iR56hssUylw8FUuaRu8cxph7L1J2wgot
	 201phLdLNGfGWXrYcVw2T325aPg8wSsHVzla1ejTNSSdPDg9USwSCFnw7LVnfr5QO+atH
	 smFQVjaQNn9g9qVa5okQK1bu0b0O2EbZbU1FMGXxlzpU51nR/XKiX/PsEPkXNvduc9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811039;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=ycM/yr/WL0cl1t5ISoVpIG6YtRxCJWSjqzuUQE2SNpA=;
	b=4VGem0PKtvBFQgrZ6SiOehVeLReMa0i9VzGS6BwsrrF1++4WtbpFBACkxrD31rPmG0IE
	 nRJ5wP8W6OIkn0RT6RGSv+a8j3+3thnDySggRA0QEhv+CjjlI8UhGkrBiklc5qWNwWUSG
	 9rGF9Zw6Xjh2FL/08z4D8/QMQa0mmdtaTjVw7FrABzQX94TGYuRSPfrsuj7+UCH5Rua3r
	 fCi2sXQ3JCWrn5AAzJAEKM8lzFdIWJICarUK152D3CO7uqCMP8o0M5k0iJ+jL/8hEBDO1
	 747veDP4xxkFNIod+NRGiuX7buSAn1Gt7XEyBUr8I3mLGrjhmDi8C1Y30eOa4GWEO0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=gehtz.com;
	spf=pass smtp.mailfrom=gehtz.com;
	dkim=pass header.d=gehtz.onmicrosoft.com header.i=@gehtz.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-gehtz-onmicrosoft-com header.b=WyxYyu+x;
	arc=fail smtp.remote-ip=40.107.160.79
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021079.outbound.protection.outlook.com [40.107.160.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE08606D81B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 16:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AE08606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gehtz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehtz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gehtz.onmicrosoft.com header.i=@gehtz.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-gehtz-onmicrosoft-com header.b=WyxYyu+x
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIdgOjx6zYL9Q878+5L8Fw5IcPMMpktn1L3Di6t9Mf8kL8xnTaREMsCzCbOzSKVUVZ8fGTJIZvUHi5735UZCDSxgmbXthXBJc4dIMLv67/TN2+kWUNbtZkpXiJIWvcGkMa9bGTFYsxoJQ0zd/xE0wzsqpYtU0f24DRp/Man+mzbrjTdxFezjgToP1feL+loL9TpbeQ3wKBMo77W4doAce37BAYdD5deZ41Hxo1jwPBuWCu1q31MHoCjqI8O5nAgkzVsHvXdXCiGbayInqOiZJOUNqGiqoRzPlOjqvY50J9mtwxekZm4CiCGaNTZaxW7wFveUPq4zJV8na3mAc0OM7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycM/yr/WL0cl1t5ISoVpIG6YtRxCJWSjqzuUQE2SNpA=;
 b=g6uX08+HwawsqHeeVrRvrHwkI2uhAmT7b+FW5t0VdBWkwjhu+vb5ck0GnepY43HBLQgWbE59v4tzPqBWJo6GxJ+/+Tboe+0n9hzOpqJqAS+oH5rmocIdbhrq2cAwgJ3KQnJ87fqK6EbaeFnc0XVlv4tckSyr31CZOC3lxDLOebDSPrfRih48KIyeYDTbVm2hQZA6SWWheCuQmd8mlZhTzIvpKKWFrHVZ+VNIH/ko3aR0ijNRum+j5SmMQJ4H4Nc5iw+H2j8ofmSpPLWj+WNsChtkOcURjECaMck8cHhDjKmvDAf+vA6UI8xyn9THG0yarr5QB2/Bm/2sBKKMRn1FoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gehtz.com; dmarc=pass action=none header.from=gehtz.com;
 dkim=pass header.d=gehtz.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehtz.onmicrosoft.com;
 s=selector1-gehtz-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycM/yr/WL0cl1t5ISoVpIG6YtRxCJWSjqzuUQE2SNpA=;
 b=WyxYyu+xXNAtgbqTwFiPZRe2lnbUUAPFCy/zr/bmUQg53t/RwKCev8CDeLz0H4+sDmN16itXERvTOEjLV4wdrOT9a3r4I2Hm/lQ9PfdR7cLyeDIAkLD5/SaE3H6KMDi63Pqje9BkpDipt1ADAsV/7K/gqUBAUeEzQKBma0hej3oWuB+6xH9M/UjpR5rDZFN5L6hA0XHcE1tMZGOOCzVr4AJf8nICuGoY+UuOmcPq/FqoXBDv1UBncr+eAmHJOU6pdlRvI3o2F0MJbFv5TJr8QXCPISQNAJVit0IH3y/vC6qDgixg77QTB18KwGk4E5WldsEWeQGpAA9WenE3EfU0fw==
Received: from PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:543::12)
 by PARP264MB4785.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:42d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 16:50:34 +0000
Received: from PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1523:7b3f:c670:41d3]) by PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1523:7b3f:c670:41d3%4]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:50:34 +0000
From: Geoffrey HARTZ <geoffrey.hartz@gehtz.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: "fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [BUG] fuse: auto_inval_data drops a write-through write's folio
 before its WRITE is answered, and a read caches the old bytes
Thread-Topic: [BUG] fuse: auto_inval_data drops a write-through write's folio
 before its WRITE is answered, and a read caches the old bytes
Thread-Index: AQHdbHtgKInjkaVtCkW7zRUk31/OOQ==
Date: Wed, 4 Nov 2026 16:50:34 +0000
Message-ID:
 <PAPP264MB7189832597866399467B911689682@PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gehtz.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAPP264MB7189:EE_|PARP264MB4785:EE_
x-ms-office365-filtering-correlation-id: 10ca3943-0b84-4c5f-8fe6-08df3a93be88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|10070799003|1800799024|6133799003|10067099003|18002099003|38070700021|261022105027099003|56012099006|5023799004|261102123227099003|261022115727099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261009223027099003|261022075727099003;
x-microsoft-antispam-message-info:
 dNZBJTWqrWzocAr2z7JwfmvEk0XNqlGvfCBLcZ7G3bWClX9Bdt2tB/UfDjiMAZRkr1/4rzhfoTkzyKOUyHlpa09FzZRawNlKlZaaehNvdpImFLS9YrghD/AF9KBwe8osA+qjg2KGw1qT7VFE8R5fpgaoI5xrcN3qGMEPTcAO2HUTAVJSH8R1vfp4FRPqkgeyAgS5Q+G7yDaFRla4T/Xp9aDZnr7gx3U4lMuSl0c/8m/05ax/g8zq9ozgRNWNNQr0znKbDF56FfMwQhm0BF8LGb55H0L5lu+NjdfnlzAkURW5yjC8/GVBG7q9a2vngLPUiuNzJr0+bVpDDfxECrlbggoNjMOswz7tughR3iVpmPxAfcYlR7+39GB9Kpn+BT0C6toSoIeMAoPTvMPP4BuyOtZayCsznWIUN8O+0gxWqy9VBclnXdVsZK8QS3W/fCJRtCWozI5BEYYuD72dnHzzHnzuA2LuLHvt657S1Qp06hf3SNpZZQn7Kj+kAdKTdJrRKpURyiLYlod3ONoX6NnakdEwloE7msazTPPLnmSeZj8lk20qJ+Bk4Beq3Y99xwIikKH+KePrNiBpueHoOAPGYmMkKK71AnWR3SHx/5jyqDn3eNuppMd8QNb1r8O2FjJgmTExhUtI7JmZ8C/5DAPMHte3m5MkJVbJr95igTmxPdBx64q563zCrElz2SKErZU0wlMx8MAwrdvPt4uwp5gxJg2ON1oxuDDaNAzfHaZtTSM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(6133799003)(10067099003)(18002099003)(38070700021)(261022105027099003)(56012099006)(5023799004)(261102123227099003)(261022115727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261009223027099003)(261022075727099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zExkaDtSyjGoaxkhMGRVFwKMVf7r5sSI+Vlwblhw47MbFR0Afk5YJedZ9d?=
 =?iso-8859-1?Q?IBqjq1X5MscMdbLBR5IN4SttSWOXXrIZR5R1V6RNoD2oGtAPvmfa/Xv0xc?=
 =?iso-8859-1?Q?RVt+/0LkUb/nBahuWwBeZOR9CCEq2ADZcqqQBWh4KXMTRHEv20FYZpR3gf?=
 =?iso-8859-1?Q?gVyv1KHAJI9A/JAjxd5vjDy70n4G5oB9huDe+kOYR/I4GKPtEg94nguU+v?=
 =?iso-8859-1?Q?QEZ57MjinHppYU19CsB2NWoF9wzdGXWXf7MOhDxHS2UirhKJQSIIuFa8BA?=
 =?iso-8859-1?Q?3DyFmVkS2n+4YhdYXfq1oAloJzmFBQxBIBfZiawKDoX8mlYuXAPUkqo5K/?=
 =?iso-8859-1?Q?Q+KN6tG1cKKOyN3++PlXaAc1jvg5q5Q3QxQEzVpgMZAXD73zvcjxNyA8UF?=
 =?iso-8859-1?Q?uGFynJ9b+rmJliS5TE8OeybcffV67nAOOuGELhVpzC4XJVfg8n542Uvf42?=
 =?iso-8859-1?Q?Om8PQswOX2sYknoMcyTJE4IJDfqkORPQqqVFznWENQ+3MVl0Dj+4PSCH3v?=
 =?iso-8859-1?Q?j6tFpEtugiJYLAjL1inZUv1o6aEb7H8YgJd7sOwFSeJSaAc9YnmzjYtFB5?=
 =?iso-8859-1?Q?ocPz++rBHbek9XOJ1Z2h5NZkaFQZd3cLesMUydV0bjO7dUWNc5UZ2bK3GN?=
 =?iso-8859-1?Q?sIwPuUnaqzza1x6mpGNCvxjayD7LO9QhpCDSpk6al6X1TV1+diRikv9C77?=
 =?iso-8859-1?Q?+BeX35wkkSj463BH6Lek8UcMF+JN7yF3SG+a9VjvkgM7nKJtI0LoWXuLBz?=
 =?iso-8859-1?Q?Z0dj/Fz0bASYv3wPq6d6SrRWrDN/nJmMe89MXSafBYend5kQER3iXMZ8IK?=
 =?iso-8859-1?Q?gMIpyZgCz58BFyrQLFnZmxqQ8NA1yv5TuFQRET/Q9mwsGIOn9ixuEZtjpP?=
 =?iso-8859-1?Q?+0jN7qhvG3XxcvFS6/SmD1CVDUxo4M2YA+awXgWntyBvJrUqSK8yb4ANul?=
 =?iso-8859-1?Q?C9jl+r+xuXh7eqqp3zXgY4tupZFoHJkb6r3+s5P7mt60DaPb6SsY19cLjp?=
 =?iso-8859-1?Q?FTOutFL1ONSSB6MMQ9fHRVetALqI+U+Ql1jrhm8cuKodie40XlXwsDyPT2?=
 =?iso-8859-1?Q?ev7jonQHSsGvQdPKcrqYAhtjTY+3ydwBOqaYFPlALEeTUjQ/eqZpY9kolE?=
 =?iso-8859-1?Q?KsJjjHQ1wRm8DJmvZaipsYMpLugJpIAA68lCohuAcX0Y32MaS4cH75MAFf?=
 =?iso-8859-1?Q?d6UbzFEFiCVFxg5IXkH3/muRlh+gC8Jv5qyi8DMZojUXgjKV62TviUNjR7?=
 =?iso-8859-1?Q?xn253SmpXao7+Uo2VvreQWZKb3g99IcfB0w3OJb7T3goU//LOXyilNPIlZ?=
 =?iso-8859-1?Q?5//xUV7bdapv78MY6QCEE9gHrfYReFgi4Rx5Oegsqsr3v/DtDUjsCfWsr+?=
 =?iso-8859-1?Q?K3egXqAsLQ2elkPNU0nFVarZvMpfMDjst18Oghk/cbMQ0rAmgvF8ZiBmBh?=
 =?iso-8859-1?Q?d0cLPExG8UMYoeiWYz++7SY65Ec3/FMVFiITRwR7q+MtW/sQYyjhhUMoPs?=
 =?iso-8859-1?Q?rSoOjFBUBHQjMQcVdrowWapx/gZpmSaTnwmNjCKq84IPr1E5I/rI3+jeo/?=
 =?iso-8859-1?Q?nig3ZEQCPpeMBMKFKDuJgfXIT/76HESnc41hrdnmDaOznovW1nEFJxfdnW?=
 =?iso-8859-1?Q?zCgpZh26nK1YKWnS0n++b9WiTw9a0fCcpudsySr7Ka3PoI5HthqbiiOQQZ?=
 =?iso-8859-1?Q?LABvAk358pKYzP1/65zbnN0UKxTDc9lEV+WGiwhO+9Q+wd9TBC/eis2Q4m?=
 =?iso-8859-1?Q?C+WR6wYzeRDZSkyWMuvz9unNC5d1e+aQOLdH1kvLVVtd6qqSVkqCR+2VWk?=
 =?iso-8859-1?Q?iDVKFNEY4tiUYvY85PwziwlEp231wHk0U4tkKIyZvEhdAgNEerewbw+pY5?=
 =?iso-8859-1?Q?ji?=
x-ms-exchange-antispam-messagedata-1: zlrZPiw3XCuYcQ==
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ca3943-0b84-4c5f-8fe6-08df3a93be88
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 16:50:34.0229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75a5ff28-5974-4bc2-8890-738005ef36cf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIQwOuYR80eBJP2iq3LAYg0JspyKFvW0wsihcm3yE/WeXomXYcIA/obbWIuPwTB/TKJ+v3Jk92kjQHalHhRBiVwaNod8Sxo55dLMyPMbUtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4785

Hello,=0A=
=0A=
On a FUSE mount with FOPEN_KEEP_CACHE, without writeback_cache, and with=0A=
FUSE_AUTO_INVAL_DATA (libfuse's default), an in-place write(2) can leave th=
e=0A=
page cache holding the bytes from before the write. Reads keep returning th=
e=0A=
old bytes after write(2) returned and after the server stored the new ones.=
=0A=
In our case SQLite in WAL mode read back stale WAL frames, and a checkpoint=
=0A=
copied one of them over page 1 of a database (Plex's library).=0A=
=0A=
Reproduced on vanilla 7.4-rc1 (not tainted, in a KVM guest), on Debian's=0A=
6.12.111 and on 7.2.11. The code involved is the same in 6.18.=0A=
=0A=
The sequence:=0A=
=0A=
1. Thread A calls write(2) over cached pages. fuse_perform_write() calls=0A=
   fuse_fill_write_pages(), which copies the data into the folios. Folios=
=0A=
   that are uptodate are unlocked right away ("if (folio_test_uptodate(foli=
o))=0A=
   folio_unlock(folio)"). fuse_send_write_pages() then sends FUSE_WRITE and=
=0A=
   waits for the answer. FUSE_I_SIZE_UNSTABLE is set only for a write that=
=0A=
   extends the file.=0A=
=0A=
2. Thread B calls read(2). With auto_inval_data, fuse_cache_read_iter() cal=
ls=0A=
   fuse_update_attributes() on every read, and the attributes are stale=0A=
   since the previous write's answer. The FUSE_GETATTR answer has a new=0A=
   mtime: the server moved it, for example at an fsync of earlier writes.=
=0A=
   In fuse_change_attributes_i(), fi->attr_version has not moved yet (A's=
=0A=
   answer has not come), so the answer is applied. The mtime differs, so=0A=
   invalidate_inode_pages2() runs. It removes the folio A just filled: the=
=0A=
   folio is unlocked and clean, and A's reference does not keep it in the=
=0A=
   mapping.=0A=
=0A=
3. B's read finds no folio and sends FUSE_READ. The server has not applied=
=0A=
   A's WRITE yet, so it returns the old bytes, and they are cached.=0A=
=0A=
4. A's WRITE is answered. Nothing drops the stale folio again: the mtime=0A=
   does not move until the server's next change, so every read until then=
=0A=
   returns the old bytes. This includes A reading back what it wrote.=0A=
=0A=
writeback_cache avoids it (the folios are dirty, not invalidated). Without=
=0A=
auto_inval_data, only a size change invalidates, and with=0A=
explicit_inval_data only truncate_pagecache() runs.=0A=
=0A=
Reproducer: a small go-fuse server with one 1 MiB file. It applies each=0A=
WRITE 3 ms after it arrives, and moves the mtime every 20 ms when writes=0A=
have landed since (a periodic sync, as our server does). Writers rewrite=0A=
1048-byte records in place and read each one back after write(2) returns;=
=0A=
readers read the file in a loop. On vanilla 7.4-rc1 (16 vCPUs), in 15 s,=0A=
441 to 461 of about 4,440 read-backs returned the previous record, in each=
=0A=
of 3 runs. With auto_inval_data off: 0 in 3 runs. SQLite in WAL mode=0A=
(1 writer, 3 readers) over a loopback server built the same way (WRITEs=0A=
held 3 ms, the mtime moved at fsync, close, setattr or every 30 s): 2 of 3=
=0A=
runs failed within 9 s ("database disk image is malformed", "file is not a=
=0A=
database"); with auto_inval_data off, 3 of 3 runs were clean. I can send=0A=
the reproducer.=0A=
=0A=
Possible fixes:=0A=
=0A=
- Keep every folio of a write-through write locked until its FUSE_WRITE is=
=0A=
  answered, as is already done for a last folio that is not uptodate=0A=
  (ia->write.folio_locked). invalidate_inode_pages2() then waits for the=0A=
  write.=0A=
- Or make fuse_change_attributes_i() discard an answer (as it does under=0A=
  FUSE_I_SIZE_UNSTABLE) while a write-through write is in flight on the=0A=
  inode, not only one that extends it.=0A=
=0A=
Our workaround in the server: turn auto_inval_data off, set=0A=
explicit_inval_data, and invalidate a file's pages ourselves=0A=
(FUSE_NOTIFY_INVAL_INODE, or an open without FOPEN_KEEP_CACHE) only when no=
=0A=
write open of the file exists on the mount.=0A=
=0A=
Thanks,=0A=
Geoffrey Hartz=
