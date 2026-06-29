Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022125.outbound.protection.outlook.com [52.101.101.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A323563F6
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782776138; cv=fail; b=FyGkfEIV93AkEwJ5Je+kVkmQ/RUIEuK72EWbKWdcV++E1wCOgFq5erL+njIohQ5k3oF123PeOBDEX4vP5IDw+DeBbO7x7mUbZnK/rzzjKYxHcU5ByeAEnoSiBkyUrU806mhrEj7Kr1CKEfjIV7SokB7tH0mZY697TcAXdhU5S2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782776138; c=relaxed/simple;
	bh=NSSjpir2F4YgdU9vGhnL09oVXpdka8791DA5XeDX0vM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EvvUfJbytuemQDIHZY40g33EM8CY7R5DtWZn3kEWIxNE+l7luJ8btiBakMlDj7zKerqCSvG8iFe3yDykN+y1HskF2ntkTgbL+kpmPNpAn1NOI8C8T+nws5Vua7k1FlXOw8fkEQRnIAFfBjCLgWTn9EXPbQyFpX11hBN9IptAUsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=priestnall.info; spf=pass smtp.mailfrom=priestnall.info; arc=fail smtp.client-ip=52.101.101.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=priestnall.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=priestnall.info
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRZvJ3tkwk7HIF5nczJxnUQlFqArp/WMEJWb/FOukPLrcBdeUvAqCRaGrROgFooctiDLEsZWu7uNHRnSkqwymAWEw9cXqYtm3XRYj0/KZqoCugV8wsAhspqWzwFe2g+FMjuvL/Mmjy1wkFsckydT+nVk7S7iZGCRylvIibuY0JnshMlmdLf9Y07gAcLrEhFIJu3RkdoYRvTtTOdC4O97XYQZW89A4kTAdqUcIxZ7J3IJeT6RTJnQZmyAgCk+LSXMdvxoPxT79DzDxsiGVcgae5WwwUfvVPKvrY3bOK0w1Z/Kr+X7CQlGevpkvMIBUrZ5d5svOzYMr0tTcEP+aTmk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=GfFevWjW9EUc7bXIM0VoDBhTU7b++a5wrfLSGRFRggo=;
 b=DtXOH4U75Hhy7215mdhiI8mqRcFhUfFmOeW8nu24GJzkKRuudqmryRyJlg4e3idCSlUAebG+KG94ouE5APz9YFmVfje9xBVls+OK0KBwrz1wSXOa5vraGE9kbnUwyZcPWdJQOB9xPh3LyX6efyiaK9Rrv73tn406R/OHNrDVTu0xkrSDcokI5q1FYqThsjpo/cnva4kdNcENiXWFoppkZ/+eO8wmmapQuGo3Sxa+Us/0whVL03aEb8Np+CJq7TcEEBSFxCqEN2iZxRaPyT93f6KScERyAdOYt6phrZQ7wLngcHe46miwCHyCWvUe5OxI0/7vWqtfEN2E4DgtYB5oVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=priestnall.info; dmarc=pass action=none
 header.from=priestnall.info; dkim=pass header.d=priestnall.info; arc=none
Received: from LNXP123MB3691.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:136::6)
 by CWLP123MB6526.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 23:35:35 +0000
Received: from LNXP123MB3691.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f62c:898d:4808:2890]) by LNXP123MB3691.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f62c:898d:4808:2890%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 23:35:35 +0000
From: Tim Priestnall <tim@priestnall.info>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>
Subject: Unexpected mount table growth with shared bind mount onto itself -
 expected need_secondary() behaviour?
Thread-Topic: Unexpected mount table growth with shared bind mount onto itself
 - expected need_secondary() behaviour?
Thread-Index: AQHdCB/7Z5uorHTyEk683bLZ+xFNOQ==
Date: Mon, 29 Jun 2026 23:35:34 +0000
Message-ID:
 <LNXP123MB3691574893C2958E77C8FA40ACE82@LNXP123MB3691.GBRP123.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=priestnall.info;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LNXP123MB3691:EE_|CWLP123MB6526:EE_
x-ms-office365-filtering-correlation-id: cfceae4d-be86-4a7b-6e4f-08ded6371e22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|18002099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 MA2niUvxlLLbyxOBOa/+L1ObZOwAUSiEe4XTpw7qWTfUEUymHG9eWbikDBGTC4VPxGx8zLhgl+3sxgXWvPEzYqOwh/p+5H4rYfjjuxYV5feXX4nDRyn3WmUwAVrbw/R3fKhqy28B7fl1QtOfmZ2TkUaqsXUpYQxLOudMBhOKfgwgb9jav8kkjxOGjUu4h6sStbjLYjGYoE2hMSIJ2n3RDbrOy91Trx2lO2bWDVMiN1TqgjalusXJteWWVRdvil6vQlz69GQ5aYR1hj9FwwDOgLuwVoJUDWe9lFLeimmdJ7DR0tyDNwOniz/q2uF7bWP036rQXl5RYssuWCVc/vM01u+7fY8S/VQPdPRo8uN3IFQ/D56jeKGETcldsKJwwkeUx3YWAnGb6rFOi6TaKGqdaEjCAaxHKGlUHFTWSUI9M1qoKGjRCBElkoyW9q4mBBJxnGnm+74JzyQhc1B53+jJftlF6QSK2KZXnw8Gpis0z2RymhjGJypcTsc+LTEaaQnUO/bELGrmq7ut0NDpGaUQMbifaXjavA6zoxIoGJf6VvTQD8IKigaPmrN7xBb2yQWxM4sW6+SAMgN9bJ8o4F95Fxh5PWNwDu/FnKr0nsNGMvISexJw1vjqcgtogm8Bl/FxPNOpHMoEfb1SODc0Ei7nNWpldWhnS1EQoLoph1Y5kJFP2uBp6ZgglX3AhtL5G4xkm+G3vCwm5fCFcqB+jnJbOxFCe6nRrzbV49vnhnimbfY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LNXP123MB3691.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(18002099003)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?q1vAoju9H4iX6+oa9zNYfL8uKWZCcSVUu/TwJg/CPFdYYSBacqVECtLFM+?=
 =?iso-8859-1?Q?9hnGw++HYB9VwH1s0YCllC8U0jn9k/VwH+CY8OZgAgKBWHUCut0/7AcQt/?=
 =?iso-8859-1?Q?OCUqUoutMbuRHCVVR3VJ4iKmSAO09Ug8kaYp9Xza4IhEZOjWpFRwszerXt?=
 =?iso-8859-1?Q?PM9HTc//rEckjdOuXX5bOWR6kPdLRpAV05E2/xZt6NB1A+t1O4cgQrGTpr?=
 =?iso-8859-1?Q?WdM6sOJ6Sh7DHsKmscUjdtGooZG+J7hiyvdsfTErGKuJcc4r9K9s/PE4DW?=
 =?iso-8859-1?Q?pGeGAiBmF/wVa5jV90sO2IoCQ00KudI9w5ESVduRjNkdIl27mIJWua4z+j?=
 =?iso-8859-1?Q?AALQLzMCZlEUKJztt1I+aN+P0TH1b3907RJrmsYf0/zj3DWkmh6yht15O+?=
 =?iso-8859-1?Q?DTV3YN+UBzsCikAgSgBNRvjh1MMNANBqWPM0B568LsuF/F1FA4RK9AWJXU?=
 =?iso-8859-1?Q?lWDzGhFNvXnAa7iMvjUeimc8128tTDKSGpeRZK1SPBegvQDDNOguRu9/Mr?=
 =?iso-8859-1?Q?aO+i+xHdokAWzzYodFeedr0FD06WC2TtF3fkXqMvcxEpIPDaUD+Rz5ZloH?=
 =?iso-8859-1?Q?2SeumZ+R3xasulCb/w2/fCxgjquTfaMpsAJHtKqM1bCeiL/c9U8bASJCDX?=
 =?iso-8859-1?Q?3d2yDklMlBID0+uFN6mVkwx/jtfEqbtRbml5E+t02+jz18vLeWRp9fB233?=
 =?iso-8859-1?Q?2GqFOqrF13idWo9vktD592gaTpJzofm82Ldbo6hIrrjP94KXT3mvyf0xgE?=
 =?iso-8859-1?Q?liIqn4dt+K6Pt2VyrGpQYZUPX6MbfHgA4z3cxCbKeh/S27mX1s1ywVpt1R?=
 =?iso-8859-1?Q?q6whHNuu7H1BZwSPEqPD/+izgtccos/8nPntvlMTz4oD4ZCpqmUY9HlU5f?=
 =?iso-8859-1?Q?IjXUdI/OzgGb+W+uGSqWSZaPaFoa2tBwPufrLG+q4ng5wdFbCMY6VTKa+O?=
 =?iso-8859-1?Q?cnrpwrG11AihYQMSHnquIOhiae6BZenkiiMOvugPOsLHpNVLV13/qiDwq4?=
 =?iso-8859-1?Q?Y6voy+pxqzgmTlGcFf0tCwvErYZigfPV/VgSPJ/G92uLAE+FdF/yUExf03?=
 =?iso-8859-1?Q?6SJxQR15tMGNvhmedD62huGWP3dfulDRtdzRe+0xnnwynGhM6yRbHhfsbG?=
 =?iso-8859-1?Q?7JtqmROsxPXGrOKZvnMCmD6bDT9C5v9BrKTN9Lc0x34APwYPGecVbAZp5V?=
 =?iso-8859-1?Q?Vj56GR0/Oyx/LrVeicFTkd9lV33tZk9B4wQfbSeSbYVT/l8rXgt8EGV/GR?=
 =?iso-8859-1?Q?f5GEkUzEvEarm4C5gizTPY/31V2dtYtzBKXGxPlCEiX0V7VZlIpyTyN5qG?=
 =?iso-8859-1?Q?F1B7JSefUaeDUhge1hTXJy2WOrj9B0m+AmBAhMOsX9a6MkfxkdrNnJPq0G?=
 =?iso-8859-1?Q?Unn48r/vEOsg9l9xK7DIG3/6dSvHp8FEC14fkk/9HAY79cEd1XVpG76ODO?=
 =?iso-8859-1?Q?AmnOAirxDYyLbmXPy4l3VukCciM+lYe3lRaWJCkjfFnt5fCquhFuSyMSsm?=
 =?iso-8859-1?Q?XZLdcrQEBK3lIo9+8zekufQd/4qWxomjoKknE2Ij6maq7HzGj5qiiXVHKW?=
 =?iso-8859-1?Q?jf6Z/1RPn1XhDWSgP9Pw7Afi5SsOfO1dAnGofpAo44tnnagaUOzjTVlarl?=
 =?iso-8859-1?Q?Ngx3GgoRcI3Au8pCm8lj67Mg3it4z3xUvMaJlIWYrpSLlYB1ZBynG2MeAy?=
 =?iso-8859-1?Q?XcTaoYNqtYkcbveums9ueVgMqDPK9Ho0XkVdi6MpWGL8zChBAYRiR4FTb0?=
 =?iso-8859-1?Q?OTPe19kOkjG1Au/HtlnQ2tVMIkzBxDITK1WI9TaPQPY1/v?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: priestnall.info
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LNXP123MB3691.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cfceae4d-be86-4a7b-6e4f-08ded6371e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 23:35:34.9935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5a35e03-c2c3-4da1-af74-6b49a0269675
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rB4GLnb6QP72Mxcn++/yH+J2p4U5g1uLquqyNWig8MCnztqCRzb8itR4xGHYuAUZf2m8HsbmQZxCr6xPDyfXpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6526

Hi,=0A=
=0A=
Disclaimer: I should be transparent that I've been working through the kern=
el source with the help of $AIAssistant - so while the technical observatio=
ns are based on the actual source, and I have managed to replicate this beh=
aviour myself to confirm it, I may have drawn incorrect conclusions from it=
 in regards to "expected" behaviour or interpretations of what is happening=
 "under the hood". This is dragons and witchcraft territory for me here, so=
 please forgive me if any this is incorrect.=0A=
=0A=
I've been investigating exponential mount table growth in Kubernetes worklo=
ads using bidirectional mount propagation (shared peer groups / MS_SHARED).=
 For example, say we mount the following mounts, with bidirectional mount p=
ropagation method, to the pod:=0A=
=0A=
   - /mnt/a/b=0A=
   - /mnt/a/b/c=0A=
=0A=
Whenever the container crashes, a new container starts, and the mount for /=
mnt/a/b/c leaks back down onto the host via the /mnt/a/b mount (I think). T=
o be clear, I have a confirmed fix for this particular k8s-centric problem,=
 so that's not the question... but what I expected to happen is that the /m=
nt/a/b/c would appear in the mount table X times where X is the number of l=
eaks. Instead, we get (2^x)-1 entries for the same mount, which feels... 'w=
rong'?=0A=
=0A=
Tracing through fs/pnode.c, the mechanism appears to be:=0A=
=0A=
need_secondary() calls is_subdir(dest_mp->m_dentry, m->mnt.mnt_root), which=
 returns true when the two dentries are identical. In this scenario, every =
peer in the ring is a bind mount of the same source, so m->mnt.mnt_root is =
the same dentry as dest_mp->m_dentry for all of them. The "skip if mountpoi=
nt isn't visible in m" check passes for every peer, thus every peer gets a =
copy_tree() clone, every clone joins the ring, and the ring grows exponenti=
ally with each subsequent bind.=0A=
=0A=
I have reduced it to a simple reproducer on bare metal to confirm that this=
 is indeed the case:=0A=
=0A=
  $ mkdir -p /tmp/test/dir =0A=
  $ mount --bind /tmp/test/dir /tmp/test/dir && mount --make-shared /tmp/te=
st/dir && cat /proc/mounts | grep 'test/dir' # First generation - 1 entry =
=0A=
  $ mount --bind /tmp/test/dir /tmp/test/dir && cat /proc/mounts | grep 'te=
st/dir' # Second generation - 3 entries=0A=
  $ mount --bind /tmp/test/dir /tmp/test/dir && cat /proc/mounts | grep 'te=
st/dir' # Third generation - 7 entries=0A=
  $ mount --bind /tmp/test/dir /tmp/test/dir && cat /proc/mounts | grep 'te=
st/dir' # Fourth generation - 15 entries=0A=
=0A=
Each bind mount of the directory onto itself roughly doubles the number of =
mount table entries. From experience, it doesn't take many of these leaks f=
or the host to completely grind to a halt, and as far as I can tell, anythi=
ng that needs to touch mounts (like containerd/kubelet) is totally hosed, a=
nd sys cpu% starts to get a little toasty when you reach 14 or 16 iteration=
s running it manually like above.=0A=
=0A=
I did come across something by NeilBrown <neilb@suse.de> whilst digging int=
o this, where he had to use the pattern !is_subdir(workdir, upperdir) && !i=
s_subdir(upperdir, workdir) in fs/overlayfs/super.c to check if they were '=
proper' subdirs. As someone uninitiated in the ways of the kernel functions=
, I found it quite entertaining that to check if something wasn't a proper =
subdir, you must check if they are both subdirs of each other. But this did=
 get me wondering: Given how I personally would have interpreted the name "=
is_subdir", is this behaviour in need_secondary() intentional, or not?=0A=
=0A=
I can't think of a use case for this, but then again, I'm not familiar with=
 the wider usage of these functions, so you'll have to forgive my ignorance=
 on that front. It seems like need_secondary() should maybe return false wh=
en dest_mp->m_dentry =3D=3D m->mnt.mnt_root? Especially since propagating a=
 mount into a peer that IS the mountpoint is self-referential and produces =
exponential & unbounded growth.=0A=
=0A=
Kernel version: 6.12 LTS (tested on 6.12.88-amzn2023)=0A=
=0A=
Thanks=0A=
Tim=
