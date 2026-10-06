Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011007.outbound.protection.outlook.com [52.103.1.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DEB381EA8
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2026 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325371; cv=fail; b=YN4MIM+uA+AKXQGnd7Cc/uPeYypGk7U5sJDzeLGjEttNSL4nJpid8hEEfRirPng32yyry8cmJ1PifEaD2aA6cbdtxGL/+BNGDh24NSE6IIaTJD/em8M8zLKM8RKlsyilg4mDI9OkUV0A8Eg3F7EN7ZwkxaB4IGJmDnlnDlfiYek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325371; c=relaxed/simple;
	bh=gJt2Rr2JtTzoGyWwzQ2ztoMa/Z6pn9Vi/13aisfbrUY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hqSHf/d4yh6YE9M8VTnZxV1/YycYPSAl0R7GU00V9BLFtKIRDlbFViBLxIwTanYkxV5ueVYpOycDgObgHTWD2dYCZa9193p7d9oR1sqkSLWBVghXtZtCjnEChOw1B9aX8djzaAs+NPk1+bmeTKWLaWjUJpyxZc564AX0eG41p0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ihy1dryN; arc=fail smtp.client-ip=52.103.1.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ihy1dryN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRTsyc7bs1iT9CyPmjfez5YHPQj7TzaHAQhW21aMAp5wLYIHtXPzOegsHHFhX/Sb/Tjp88bBIIDH1sbBcTRR4NKw1RUAcGM6Ss1jEOOiTe3sh+S5HMfg5VT1rx5Zvo9Al2e2JYYdHcDmsonJmVzAPeLSinZDuyJ9x7kUPxxFnYoib60Gk+Gg/wMyzQUkE+7Wq+3lHEvsUWPTN23eBRr/yF23Uc5OxZWMI4kpP0GNV3fmqwTojwUdk9SOr7J09qp9eQJCQz5IhP2icSfh+vQU3AQYli5cGWiPBsD7Y0ZC+GcWaqyFMYaxm+Fq4sduuOD7XQ5MBi0QTIdFgynn7s2SWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJt2Rr2JtTzoGyWwzQ2ztoMa/Z6pn9Vi/13aisfbrUY=;
 b=CMeFowoEQDbUGDVaIVE25Bs142xMzNORAgivu8azoKWKeVAurJYXew/cGzQ2UaaFRTyh1AN+hqO/oK8o8K7dfJUt0MMvb+DpZfsylHPhR9mwonIJqD6LEVX3YYrRyDwfsOV5r4KWg97jH/1P6uk4mpc4ZwC6gv0mfFldio5qZ27L2ljGXuMFEkRVL7zbewlXqQuPNh2UBznX3ctPaCqZpMSPwjQVpI112ZvRMVBSD4gp1ufduaMGL0RyrRK2nsBui07hlmy15MGHn1BainoezRwVp0BOKQqU9tF5ycaWb5/42BxiWNKnSZ/HJuSApTwXRhUzPKObEARqnr2QjWfVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJt2Rr2JtTzoGyWwzQ2ztoMa/Z6pn9Vi/13aisfbrUY=;
 b=ihy1dryNZUOxxqyqKwxSy83iqIjTNlQkxgqvVoYpmRX1xFAndo3b4zqWoo8AmNlNP8VdZxrrMgRFSvjoCEkPDKopoQgWS2fLLvMFj4KUDjvClsNvdG7q58NLJDsNGHEe5SnizOGXXmP/f8Lf38qdBKrVJ3kaNQkJcJGZxfQ3gXchkUyxfvQlTEgLnrlGlj7cHg1YgLwU5voLpfbc5UcIKJEsz3uTgMm82+cPeOJTwJqn56rqCKvX8IefYzLkMbVpA2JzevzLnoRQxvBrANWbVsHeAo9MiaHrrXDc+upVaI023z5Asq4Ih0tP8RlIvcUHneDkGi2aNnPQJWeS0oZANA==
Received: from DS4PR04MB9846.namprd04.prod.outlook.com (2603:10b6:8:2ea::15)
 by SAWPR04MB993655.namprd04.prod.outlook.com (2603:10b6:806:561::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 22:22:47 +0000
Received: from DS4PR04MB9846.namprd04.prod.outlook.com
 ([fe80::f475:2ef9:2387:5e0]) by DS4PR04MB9846.namprd04.prod.outlook.com
 ([fe80::f475:2ef9:2387:5e0%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 22:22:47 +0000
From: Danny Pidutti <danny_pidutti@hotmail.com>
To: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Amir
 Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Subject: [BUG] nfsd: unbounded slab growth from exportfs reconnect_path() on
 disconnected directory handles (deferred fput of get_name() dir files)
Thread-Topic: [BUG] nfsd: unbounded slab growth from exportfs reconnect_path()
 on disconnected directory handles (deferred fput of get_name() dir files)
Thread-Index: AQHdVeBzgKAordaeSkuUumCfAeks1g==
Date: Tue, 6 Oct 2026 22:22:47 +0000
Message-ID:
 <DS4PR04MB9846BA3C16BC5ACED8B589228D952@DS4PR04MB9846.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR04MB9846:EE_|SAWPR04MB993655:EE_
x-ms-office365-filtering-correlation-id: 831ee5d5-bc6d-4386-d931-08df23f859a8
x-microsoft-antispam:
 BCL:0;ARA:14566002|39105399006|15030799006|15080799012|37011999003|7071999006|8062599012|31061999003|4140399003|25010399006|19110799012|8060799015|25031999004|24071999003|12121999013|24021099003|20031999006|2607281247196008|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6B1NiRtSMrARUEIb+smZ/QlYjKz2jzRomcAaSU+FebSLJXnsDOZGceFP4y?=
 =?iso-8859-1?Q?n1pe3hGjzniKuJNBq81px+AhQsHXfNwWYTUwx5aRGfn6IfUQycZBKo8JTM?=
 =?iso-8859-1?Q?MwMqeHOpUFV1zkKBRiJp5e+3Vi8/NtaLXrWnsjxginyEu0ng8wiQrLZhix?=
 =?iso-8859-1?Q?+iYHwCfBO7BnMcQji61oZPHLKEDppzA0fbSjgYMAX3yZvk2xZR4twKQXTj?=
 =?iso-8859-1?Q?XSi6kh4EfXy6d45skeWanJH0MR3Jox+g89umOyncxotp+q1knkh315NEi8?=
 =?iso-8859-1?Q?LoGd1Mewn6pxi8mYRaW6f/+IDwMvTjXGcDh9yjDjixQDyjLdXS53L5Ec07?=
 =?iso-8859-1?Q?tSx1h/TkGSQxyIvYkC8TVIdANaP6pJz1wvhRXMVDdQYgIa4aiMyQJuPjJn?=
 =?iso-8859-1?Q?wMqJpriqjQxtc85jqH+Naxb42c3voOhXICQGocVIwnXr9PzdQBiE8pmnYl?=
 =?iso-8859-1?Q?deRBvxRElhdKRrXOdywtLxh/9u8btyt/b2fAF94/9d3CzmvA7rh/igV8u/?=
 =?iso-8859-1?Q?VhoIPYH7EV7zLgdXXiye1sUPk/ZGovZhdDwbRacVTyyZXat4pcDhld+RPY?=
 =?iso-8859-1?Q?rHlPeXEC6Ap6tdspxf6kuOyXpnwLigXbYD+RgFU+jwCIf7FTN4loyCj2ys?=
 =?iso-8859-1?Q?TX+99aXVpelBjf3bQbVDbLSg6fIt9na7UqmIHNxAaafYIgf2CWk8NNDrzs?=
 =?iso-8859-1?Q?bOIz01ZvbhnspB4cVtVy5IHJ2zAqbNN0JAvUHZQAgMwyTnbJ5+CPwUfeNl?=
 =?iso-8859-1?Q?s26VEo0qO49DSXMdh9GZoft7ituo8TEAZRhggDeAot1VPsjlXRfdWCtehb?=
 =?iso-8859-1?Q?SAqlHMZEx5O/kG8Z2AzjIZBoIqv2Y118rulIWPpSYdNyFsTFWh8TwVc501?=
 =?iso-8859-1?Q?Aq4leqvfpsaeD6Iza6rktT3TtFcWlJnQLLiJKWfD8LGsBi72wgogRfaRuC?=
 =?iso-8859-1?Q?6NHUlU7WX2DUackc1eetZrBHW3+k7qq8ifJgyJDeokDpgGD8J8KfF7OX4F?=
 =?iso-8859-1?Q?/G3GYWtfrl2dAf79vnn6QiOVz4mFTlaL4dH3uykzroBNScioAJsu6WgL8X?=
 =?iso-8859-1?Q?mCXAfj2+ieKcLQUbabWyJyrY3UZIGEiilk3GwN+J2yoxqh4OldhXwnAy2F?=
 =?iso-8859-1?Q?sLYk1IgaA7ye8GZ8SNwp6/0CcRBpEmxs23nV81IzVjM7zfBRoOxdxLMH/1?=
 =?iso-8859-1?Q?gof1Rbm6L55VGCf/1ZDbxf4NPRwG6zL4MpU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PY+78MUTONtddN1yIa54vruQJbe5DNIDBQo/X3BdKGFlOlruENSnEfMbGn?=
 =?iso-8859-1?Q?a0SZ6Aqu3slerRmbPnqhz0jlxEw7YerceEtX+5WYQ8tMARxqXxOP34Ucxe?=
 =?iso-8859-1?Q?i9rVmZrzz4XNf1koNTIe6dgF2uoYjJnBukrTUSIDizgCcuwwT6GOiSBbmA?=
 =?iso-8859-1?Q?p8tkJHlD9fIiJPZ2yjaGbviYf9dJ9aNEtwh/divjLtTSeQXZZQa0+9Jsoe?=
 =?iso-8859-1?Q?gY2uvlSQVe/X3nnlOcfk7q9/8vAFsQmrco76izY67wg+9MWykJRnM7K5PI?=
 =?iso-8859-1?Q?s8kfGiO9MbXAzj94kMihSFfRXgrzJGI3zw2o2AJU8t7Toda2vkOf628aph?=
 =?iso-8859-1?Q?nYJkoAP35qKgIbVF/O8MP8303nZfunteesEkDdCJ2TIlx0y1nVh49z/Hry?=
 =?iso-8859-1?Q?Z8+cP9w616IAWiMZaD3exo8GUMTxEmPTI4LbHaYZ6uPyAOarV4X2aGDCWm?=
 =?iso-8859-1?Q?fYP7IesAJxXNm0fDTfkaa3WXl3Q4KZj/wHCvHLYYcEWwmc/V2SZrdtSEfx?=
 =?iso-8859-1?Q?PCD/zOXxeLlOJZUJwlohzeirWU+zqAmHqnsX+SAn1YcZBJUrP6fwzW0Xkt?=
 =?iso-8859-1?Q?CqEBwNma0NKnFevaFV7wwt7pROsVT5wCqC8NyEfAe2qYk+OZ/0lDmSWxcb?=
 =?iso-8859-1?Q?EVnGo01O7W30lk43YqvNxrCQh0sXUMPe8O3vN5RhdntX/5ZDQeY764Y3wJ?=
 =?iso-8859-1?Q?OxbC9uZLiIR8Nqe1vPmdECiRsV0gC6Vnt6O3DtdAb0c+pBZ/RHjKWQcLhF?=
 =?iso-8859-1?Q?GHjYTZuZJ1oeXPEGdaQ9F3wa/afE7VznVGKRiav4oz0NkVz+i/drzPlXOp?=
 =?iso-8859-1?Q?AQpLhg895ColouRERyxJRKa183kzW58zHZ2+qEKCYRTDudcvaCRLpE+WDN?=
 =?iso-8859-1?Q?+rxof0TqzoYSWgH2slhDx0bNG8KZjzdIDAoB0wXyEWBfw6znfcIKMB1tVe?=
 =?iso-8859-1?Q?ZX2aXOYe8zAsOsBOmevlqg/F0nVwC/51BWRXMeL1hxsxZ/iWNDg8dT2ZDf?=
 =?iso-8859-1?Q?l6wz+j/3rOGDbgwyE/QjDQAVBNRhRtPYamJPRZQ2Z5ua99LaH1szFnFs34?=
 =?iso-8859-1?Q?C8bLDdx02fN0dD2LG8GKfufbdxCNMQqbkvDt71kvKyvJiohhKTjGVwEYr6?=
 =?iso-8859-1?Q?NmrV8Mnp8yaHqX8yEJENjKEcFhWX661uhs8iR4nbQehhsJ7pw2OLLBk+mk?=
 =?iso-8859-1?Q?Gsziy/7LYOEdjEWgtmiV91L93aQUqmYiGAleLv28xfsrqxp+zAhSzG6eh3?=
 =?iso-8859-1?Q?5WEx03ze6qcDjdH78YSDISlKBqrNX0HiMUpTQpNMEblwIT5vPdoSjWTJJi?=
 =?iso-8859-1?Q?T2k7nhTnG0V8K0WqwiVBN3BBTuYZ5UUFXS62tXx596UxRkRUZ3Xgfwa2rL?=
 =?iso-8859-1?Q?LP1XowgiKDP/j5rDAL6UkganXiStkeeQMUP8g79I1CG4PTCMwpJemD0GtU?=
 =?iso-8859-1?Q?BEbaPwqhuGP6/lmD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-7fd9e.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR04MB9846.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 831ee5d5-bc6d-4386-d931-08df23f859a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 22:22:47.2943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR04MB993655

Hi,=0A=
We are hitting unbounded growth of unreclaimable slab on an NFSv3=0A=
server under a directory-walking workload; on an older kernel it ended=0A=
in a global OOM. With slub_debug=3DU the growing objects are ext4 htree=0A=
readdir caches allocated by exportfs reconnect_path() -> get_name()=0A=
during fh_verify() of directory file handles. get_name() releases the=0A=
parent directory with fput(), which from an nfsd thread is deferred to=0A=
the delayed_fput work. Under load the queue of pending releases grows=0A=
faster than it drains, and every pending struct file pins its ext4=0A=
htree fname tree for the whole parent directory, plus the file and=0A=
its cred.=0A=
=0A=
Environment=0A=
- Server: KVM guest, 8 vCPUs, 64 GiB RAM, Ubuntu 24.04,=0A=
=A0kernel 7.0.0-38-generic. Also reproduced on Ubuntu 5.15.0-194.=0A=
- Export: one ext4 filesystem (dir_index), 3.6 TiB.=0A=
=A0Options: rw,async,all_squash,no_subtree_check=0A=
- Clients: NFSv3 over TCP from 10 hosts, many connections.=0A=
=A0Workload: a parallel tree walk (~8.1 million files, 1.24 TB, millions=0A=
=A0of directories) that sends READDIRPLUS for every directory, plus=0A=
=A0concurrent READs of the files at ~1-2 GB/s.=0A=
- nfsd threads: 8 (=3D vCPUs) is stable; 16 or 64 reproduces within=0A=
=A0minutes.=0A=
=0A=
Symptoms (kernel 7.0, 64 nfsd threads, first ~2.5 minutes of a walk)=0A=
- SUnreclaim: 94 MB -> 8.4 GB (about +90 MB/s)=0A=
- 64-byte kmalloc objects (sum of kmalloc-64, kmalloc-cg-64,=0A=
=A0kmalloc-rcl-64 and kmalloc-rnd-01..15-64): 15k -> 114M=0A=
- /proc/sys/fs/file-nr: 1.5k -> 609k=0A=
- Within ~20 s of cutting nfsd back to 8 threads (or stopping the=0A=
=A0client load) everything drains to baseline. The objects are freed=0A=
=A0eventually; it is a backlog, not a permanent leak.=0A=
- On 5.15 with 64 threads the same growth reached a global OOM:=0A=
=A0kmalloc-64 ~43 GB, filp ~2 GB and cred_jar ~1.6 GB unreclaimable,=0A=
=A0page cache nearly empty, oom-killer invoked from nfsd.=0A=
=0A=
Allocation stack (kernel 7.0, 16 nfsd threads, slub_debug=3DU on filp=0A=
and all 64-byte kmalloc caches; 2,848,892 of 2,866,052 live objects):=0A=
=0A=
=A0ext4_htree_store_dirent+0x40/0x140=0A=
=A0htree_dirblock_to_tree+0x1f1/0x390=0A=
=A0ext4_htree_fill_tree+0x298/0x450=0A=
=A0ext4_dx_readdir+0x283/0x390=0A=
=A0ext4_readdir+0x712/0x8c0=0A=
=A0iterate_dir+0xbe/0x250=0A=
=A0get_name+0x181/0x1f0=0A=
=A0reconnect_one+0x24f/0x2a0=0A=
=A0reconnect_path+0x103/0x130=0A=
=A0exportfs_decode_fh_raw+0x3cc/0x4d0=0A=
=A0nfsd_set_fh_dentry+0x2ea/0x4c0 [nfsd]=0A=
=A0__fh_verify+0x2a3/0x3f0 [nfsd]=0A=
=A0fh_verify+0x41/0x90 [nfsd]=0A=
=A0nfsd3_proc_readdirplus+0xa0/0x220 [nfsd]=0A=
=0A=
The directory files they hang off are opened here:=0A=
=0A=
=A0ext4_dir_open+0x52/0x80=0A=
=A0do_dentry_open+0x13e/0x4b0=0A=
=A0vfs_open+0x2a/0x100=0A=
=A0dentry_open+0x35/0x70=0A=
=A0get_name+0x13e/0x1f0=0A=
=A0reconnect_one+0x24f/0x2a0=0A=
=A0(then the same reconnect_path / fh_verify /=0A=
=A0=A0nfsd3_proc_readdirplus path)=0A=
=0A=
The live objects on that stack were at most ~11 s old (age=3D in=0A=
alloc_traces). The nfsd filecache itself looked healthy: ~15k LRU=0A=
entries, mean age ~2.9 s.=0A=
=0A=
Why the directories are disconnected=0A=
- With vm.vfs_cache_pressure=3D100 the dcache held only ~120k dentries=0A=
=A0while the page cache streamed ~900 MB/s (kswapd reclaiming at that=0A=
=A0rate). With millions of directories, most directory handles that=0A=
=A0arrive have no connected alias. Nearly every READDIRPLUS then needs=0A=
=A0reconnect_path(), and each get_name() reads the entire parent=0A=
=A0directory, building the htree fname tree for all of it.=0A=
- vm.vfs_cache_pressure=3D10 slowed the growth about 4x (at ~3 minutes:=0A=
=A06.4M vs 25.6M objects, 2.5 vs 5.35 GB SUnreclaim, 50k vs 146k open=0A=
=A0files) but did not stop it. The dcache peaked at 6.6M dentries, then=0A=
=A0fell to 2.2M under the same page-cache pressure, and growth resumed.=0A=
=0A=
Analysis=0A=
The nfsd change that switched nfsd's own closes to __fput_sync()=0A=
(posted as "nfsd: use __fput_sync() to avoid delayed closing of=0A=
files", in mainline since v6.9) addressed exactly this kind of runaway=0A=
delayed-fput queue. The exportfs reconnect path is not covered:=0A=
get_name() opens the parent with dentry_open() and finishes with=0A=
fput(file), so when it is called from an nfsd thread the final=0A=
__fput(), and with it ext4's release of the htree readdir state, is=0A=
queued to delayed_fput. Each get_name() on a large directory allocates=0A=
one entry per name, so this backlog is very memory-dense. Much of=0A=
nfsd's system CPU time in this workload also appears to be these=0A=
whole-directory scans.=0A=
=0A=
Possible fixes (suggestions only)=0A=
- Release the get_name() file synchronously when the caller is a=0A=
=A0kernel thread for which that is safe (as nfsd now does with=0A=
=A0__fput_sync()), or let the caller choose.=0A=
- Avoid building the full ext4 htree readdir cache for a file that=0A=
=A0only get_name() uses.=0A=
=0A=
Workaround in use=0A=
nfsd threads limited to the number of vCPUs (8), plus=0A=
vm.vfs_cache_pressure=3D10.=0A=
=0A=
Regards,=0A=
Danny=
