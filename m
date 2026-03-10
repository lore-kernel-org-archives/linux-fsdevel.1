Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61275389E1D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143050; cv=fail; b=sHSDRRylzCHSDVENZpEAtgYwaEnfZgB9DLl56/N29RSHf/6xBrtMdQ89rpANqzD6QRx2oU2XYWkIhZaNhsQG4AuboVWJWezZ2Br+c6ipDidaRaVNar8YhDPKUwZdbKpslzDdRM8vNCws3XqLw5PqwgZXQ+dn8vvNJvGNbKLvDP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143050; c=relaxed/simple;
	bh=s6cKcl2M6jwOVRzz6ph8KutIYymPrD/Af+1lUtzhIPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6Y6J4N0lqSLDEVMcF7UhF+tVw0+cHw++KezTIsC7nI+OMFjJQECpRX49SR2JwsjoQ7DAMLOKvQB76MjLB0mvewI/yy5S7DbmxfkFdHNz5EQa4ED9kZJARN4ZVqLQqjhMmWOVEsJ0keOFDsbk8Xfky7rRTYK/JtOvbc5qRc4QrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EIoeb2EJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AyzkXNJm; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EIoeb2EJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AyzkXNJm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773143047; x=1804679047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s6cKcl2M6jwOVRzz6ph8KutIYymPrD/Af+1lUtzhIPw=;
  b=EIoeb2EJxHiu68cz8nclWqP72nCQtvJdT+dJbsAQqyyRO747xC7HpeYq
   IF3FlxhLtR+qJ60FzRmeOhkI2WaW8plLUoFGnYZMorRvquhQ7RzaK0JHO
   areaYcevocuEJT/SKCD1goUUNOi7JARRMoZf3P55UsEm8WiaXevyvYZ45
   X1SYEvtO6qzk2vosi3twHCD0o++2qt9p7czHclqFfRD+a69b/1MT+mrE0
   hoVmty1TpJXh6j3OnYR4Tu5kVXe30ImBgV3uW+FYr0oVeyxvDjyRDdtZR
   7Uqb8vJvY13zHYnYqX8cNpGFeUIijxNdGm4lk2gJOhep9pjqKntrgosQi
   g==;
X-CSE-ConnectionGUID: ea0iqutOSDaO1jFaKUjhUg==
X-CSE-MsgGUID: zKlbsgFcRmCuuzcMEgL3kA==
X-IronPort-AV: E=Sophos;i="6.23,112,1770566400"; 
   d="scan'208";a="141258255"
Received: from mail-westus2azon11012048.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.48])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Mar 2026 19:44:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4qIuScxmQjXRfJS7YMm9v9AhHIu77stBONItzAiy89jI2dB1OXtICFS2fMJF50J8lsyhOA6T9427gl9aiOvJYEw6zlg7EghD1GAuNV/5GJ1JAgEctmp+Ib7z7/ZNeBMTwGJgBFJaR0jYXFcBmT0DtKNsHcl/At2zBRS3jb0dUEyt5rCi0HihHQJ24PG0xQMrLHDZUQT1OLAWSU34QYKXKcv6piawwuGj4vgMzSEE1Kb3EBSNG2GKOyAW0b3oNvZRM8UFOyi26SFFmati2ubrdazH4zMhNFr2ORO/5U1ArVcbIpFg5b5TXfUu6jXQ3r5YHvQRx9sjuLeklcQQrmW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6cKcl2M6jwOVRzz6ph8KutIYymPrD/Af+1lUtzhIPw=;
 b=jgKOmMPntquRBhCdnRZIcu7mL4RwOrSIy0gU7YgfEtduVCc13U4OpwQvefghqqx9KfGNPcP4iMT2v/ES6Q1BQI2jjm/aihIhnhEKgNGzrZdxMimqNor9RO8z/VWWbbxX4GPsqwVG/z4E7E5Pp9RHd77F9vrs1+XL3za9Y5GWNrJdwJdw4z5inQyz6nfLhkMcSmVVCEv4IXwT15Kf3Jy8CHTk8WqOWbyVm4bOJVIppaDsUQg5Cy2+JS7S1PuWr5M0rQOWus5KhJ3/K2Zdgc8isKiqtzk4p4pB6cielIYXBjz93ekrfCDHUR90dS8Ot8Wr+go4JA3+WT5AJILFtJHeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6cKcl2M6jwOVRzz6ph8KutIYymPrD/Af+1lUtzhIPw=;
 b=AyzkXNJme4peg7nhG4+zmIRSx2CGjmozvFqao0pwtmOGs73Sok5Nc/a3euDGjtmVTNTfNwmHy05V8MZDZq86eLWPQxHWs/ImF65i6aPDWCSJtH/ZXvxMTQunia4R/uFUiiPQE3q/FfR1qiK+pBBSFpDY/LkzxGZW2nxdimKer/4=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DM8PR04MB8008.namprd04.prod.outlook.com (2603:10b6:8:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Tue, 10 Mar 2026 11:44:05 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 11:44:04 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Joanne Koong <joannelkoong@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Hang in generic/648 on zoned btrfs after aa35dd5cbc06 ("iomap:
 fix invalid folio access after folio_end_read()")
Thread-Topic: Hang in generic/648 on zoned btrfs after aa35dd5cbc06 ("iomap:
 fix invalid folio access after folio_end_read()")
Thread-Index: AQHcr+L+JUP1D/qCgEyjtOWbIuNrhbWmrpsAgAD4AgA=
Date: Tue, 10 Mar 2026 11:44:04 +0000
Message-ID: <35327273-23ae-4fc7-93b9-03bd4abf631a@wdc.com>
References: <b3dfe271-4e3d-4922-b618-e73731242bca@wdc.com>
 <CAJnrk1a0BLS1+1uf8BqKCZ6+vXdxDHkp3WtjGgz8A4e=sx9C0g@mail.gmail.com>
In-Reply-To:
 <CAJnrk1a0BLS1+1uf8BqKCZ6+vXdxDHkp3WtjGgz8A4e=sx9C0g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DM8PR04MB8008:EE_
x-ms-office365-filtering-correlation-id: 5884f85b-9c9f-4173-feda-08de7e9a54fb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 APgCYWWDxClW9NuGWeGLTAzbviZ9k5fmrugjn8aczJAlwolJxAlsI0+ZExTgbPYGU4o7tvNaL3nRsdoJIyrAKkpNVvuXzmLqgdAc3GZgWO1Rrr4QzMz4DmNRyJm7UjFKpFBARp8iQDGcSiC2xHHP7+lT/1D7DPED+aSn9O3sim3QKAv+w83mxLJYMuNFt1dYQxCZImHujj8PYL7onuAn6JsP/hBQEsKLRx9HjOkH5jfIRLW4+W4ADC8W7OrlPAGSWIaaTvo2GvPvFQ4mmmVlyw3AgT5rhQJNkJNa4lSFkOvrSR7rPHQH6xJBxBYI87cqPtLTaa2RF6T0ISFVrCW4c5J7tiSvb+cLN+LU1m+ydSy0jjYsfp8AR7Pvk1SmSCxZA5xp5gsr/8eBlfpzz0DHjDspMQzlk34n0YzvdKkIxLAheoboe5L1BX+nYDDI3oh8jvMMVB2z1gOnu5UICwAlF0Qth0/JyXiZmk5IZAkGjQU3GirUfZKQlnMxi8yEXayKTEqJZQb1MbJVF5nHLxBGDxoG7u7PwcuLAIpxq2ixkdpovyyG3l+WPTcSDgFqO+P2fOxNUcsMx2/IEYhJfT+GK4LvNs85+g7GGMf+IJr8A/AAbNACtiaLzTZUwDIpzPHvl882Mm6J/yFOmA/AGzb7csvNuRtTywM+YpJmWXXymyyfdgNU9AaextTK52GVXN31M84fmZ6TIHEW86MDILVBmHzXo+jozkUd2I6bXv75X1hO2Fm5TOQj38/SZQ0UH9Nc+ifw4VARwRMlsRLSrTEiUAbqzErs4+tgOq+3vZ9JxY4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEk1MTNHWEQ0MWtBU09VakFJQ2FFQjVqRkJ5SnZnVE5wZnBoR09KRVkxMGk0?=
 =?utf-8?B?elJtME0raWRCNWpJUEFYMFozU01KZTVFQTVUaTd2anN6ekFaK1VrS1Fzc3c4?=
 =?utf-8?B?WjVBZWJNVm0vajZwd2s5a1B2Vlo4UGNyWWs3S2NLUHdCUlRaVnIxNWp2SU9s?=
 =?utf-8?B?b3hENUVVdnBjZDMxdmtkSGR0T0lrbnBwRFNIWWMrUHdSSlhvUVk5TU5YeE5n?=
 =?utf-8?B?b0NYNHVyamYzcWtBUy9jeGd0R3QwdDVqR0ZVWFNjNVZhb25uR1g5WEpEOW9Y?=
 =?utf-8?B?QWk5VHRZSGdnNXNOazl1NkZVWmZnbHlLeWFTdmpaakpUTk5sdkdYMXFnQ3VT?=
 =?utf-8?B?TmEwMktPdjU3TFAxZUVINzd1MVE0bXgwQWZnOVZsdmVraVlUQW9CbmttdzNh?=
 =?utf-8?B?M1VxQk4raU1mcitWaXhZWW5RdXV5NWFjUTFiOUJlVGhwUVRRMVFRcEVrZmtS?=
 =?utf-8?B?UWdJdnNDa3dkUmZtb0lYVzNkOGlnNW1VakhwTlRic1lDb2VXZys5empQWlFW?=
 =?utf-8?B?WERUMkpiUTdlaEdVREVJNHpteHQ1TzB3OHNWUEo2NFc1enYyczNTc0toL2tn?=
 =?utf-8?B?WHQrRnZ3ZmMwUVk2K0FGSUFmbHcvcnh5dG9yY2t4RlhoekRod3N5bmR5RXBQ?=
 =?utf-8?B?RlkrLzRaMFZVWFlHcmhhcVBmQllUbHVnbTVJT1RWc1dMRXd0dGsrUFRTQTZs?=
 =?utf-8?B?Zit3d3BMQWJIbVd2RUhQN0FFMjBFUVUzK3ZMc0I1RUhtZzdycHBtQUFLcE1w?=
 =?utf-8?B?S0xqTGpTdXFMd3RuK05NRUJXelgwN1ZyMHVkS3FjQXdPQVhXTno2RnNmRkI5?=
 =?utf-8?B?YWJ1cXhXQXhGdkxkdG1maFFTRHhzQXFOWnpYOHZxNUQvMmVrdmJmY08rTkY1?=
 =?utf-8?B?VFlyaGpmb2VEZWxCQ3huTzA3UEJDREJCdGV5Z096WFpjSGRtTjFoaEg4VWRX?=
 =?utf-8?B?dTBxQTU2d0FoVW1waWRSQ2NWM1FhbzlvSm9reGxJWmNMYnRGcXN0MjJORTVk?=
 =?utf-8?B?MFpWVytSeDFwSjM5d21nK3NXYUtLYUoxdVBOeCtKVWdkaGRMV1RmVlQzMm5z?=
 =?utf-8?B?eXZTK2tCVURIQ2dFOEgzNHIzRVJBSnNXZXliZ0YraVA4aGJQU2tqSUZvb3hW?=
 =?utf-8?B?d1A2aDhQN0VNSXlTaGkrVW1veW15WXpodk5yTmxuYzJDekJFNHN5RlFFQXhN?=
 =?utf-8?B?c2ZwR3pjUEUvUFlCVW1vampKZXNBeDl3dlQwMm9qQWR2aEZsTHlVZFhRWDBJ?=
 =?utf-8?B?QnJHMHpJY214OXFacGVtMi9ISExlVXJFOUU2T0tmaVhwZ2hGd3FWUEtoaTFF?=
 =?utf-8?B?N3VXZTFNVFFLNm9uWmRpQU5qQ3NsNkd2eVhYaS9FYTlub2pYZGNVdjZSRW5a?=
 =?utf-8?B?NGNxYVBid3dNWGVsSmpqdFQxRU83cDdDcENLSlpxK1JhUVpFb2lSbDEram5q?=
 =?utf-8?B?ZktocHQ2VUFNWS9xRHphUVJjbm0yaTUvekJaZ1FhRUZQOGpzS1FGM2JhOWZS?=
 =?utf-8?B?NTNWdHdRdjFhS0owZUxyTHdHMk9iRHZteVo0RnNQblBqQlpOU2s2RllJN2dr?=
 =?utf-8?B?all5UllHSWh6Zk9WalVJZFlCc1kwWGl0b0NZaGN6U1E3eHpnR2swYmRpNk9E?=
 =?utf-8?B?d3pOVXhkRTI4WmEyc0RkZy9WYVlhdWx6WjllSERjUWxCUVF1QmIrc2RYY1RG?=
 =?utf-8?B?VTZBV29IRTRsMlNvL2tEUVpNejk1U0xsNTJSSS9yUkw5QnVxNU9CL1VneTRa?=
 =?utf-8?B?ejUrRjAremQxLy9OOGw3L0ZUWDVTQkFJRlJqL2xxaTBVUmxPdTM1N0FIV1k2?=
 =?utf-8?B?b1h2WkdzZ1RFOEF3aVpPRGtPb3VhQzgvc3daV204N1JYb1RkTWk1MkQ0SHNE?=
 =?utf-8?B?emg3UkhKcmdjSk1QMVNvSWd5MXNUakFLVEtqZmZDTHl6d1B6a2RCc3E5VTRs?=
 =?utf-8?B?TytMblRIb2R5N0d3V0ROdGYwSW1ObGZXR1kyVWNPK3RJa3ZBakRvQjhzZkNI?=
 =?utf-8?B?bklpc2JySjkwZ0JkQWl5T01NbklHRHRhK0J4WUtSSGo4S1EzYzdxaVkzS1Uz?=
 =?utf-8?B?YXdDWnhRQzFOaWVUZW1JdDVoT2NQM1Ria1VGYXdhY1dHcjJiZ2J4Z3hnc216?=
 =?utf-8?B?N2liNHpLOEFJS0hvQmdRMVdqL2dORVB1THNHc0dPNktUSlBVMThFQnNHdHd2?=
 =?utf-8?B?U1hUdllZaDZxMXUvY01tTlBEUnVwWXcvZ3NIakxzQWJYRXlDNXZoYS8yc1NB?=
 =?utf-8?B?ekd3QjN6cmZ2ZUtWV2YwbkRYTWQxcjRUK2N3K21oUGZWajJmQkdlbkhrajQw?=
 =?utf-8?B?cGhOS05ySDc1cWh0SDJEOUdMT1hFQW9ubW1JcGdlR3Y2S2htWkplZ1FOUUk1?=
 =?utf-8?Q?NxAeJFPCQa5iyHJK1LP7p3XG6tISZMbCtuI3asRWj6BkD?=
x-ms-exchange-antispam-messagedata-1: q9S9l/7Whzo5mDAtTflupP6szsPcJJaQS1k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E2C26466301D44EAE0A9C0352661B50@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	wY6F8aS4ZaJdMuNMTN4rT/WaQh0j6RcgBIeGWFt+JEUywH5hDafVSwZDAMCuiBBFRUENhTTDi+SMeW900hN/SLdukGlpdAZ59dw7TQN0WlcCCzF9gJRoiBawwHPC/AMV9ZnU6nIjrIO3Ewvzc3kyHydsN7h4FsKXRurKkzR/VuJgF4QSZrz5OaiKXyXNoxkCL6wxIp2W8ropeTiwZX/WHJ3l0F4XR07CNdEPTNieNH6iysp61Yju9xFPJVarMNaqVrnb2z8jd32krxMQcKzDoLylYd/vgnFgAuYNIuJOwKBrOXoRp8TrbdRbNZn2P++n4kvmJqBieqPPZ2FArtLlNg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R2i6CZptXfWiy3P+NhiTR2A+bpVbBnbqrwuqhD4DVE13ffH8zYcmoiSAQkCdwibk0mGEod5NWL+iqqcbx36E/wa8a7+uCjgotWxQ1jCFyiWxuZPaaFlPsuY8vp+KgUG/Cy1GpaLcHP/NNsorgdO1Bmi+vo+DP0DYxRnx4GIQXEyej0nuA/kEY3zvkgo3i5/3tNPPB5MtJ99xB7gu3T4L1zUCXHy27mwp+Dfj2m3bN4UOHB8MPR2QXPaFb6omkB4q923nHLgemnVp36U2uK8/dE+EDE4jf0hDzwMGbSPYjOQ/AMEYDfjSf8T7qFz1cJs5YC7TZ1Rn2mkeCDn4tPe4sbvBRaAq+9PpwyvBsVuyjjL9zhva5wgqerYCFe5rPlyuIfMJalw5pOTCB57WbGl1RjYNSiSP7VgzkcSlpDpq7AvRPASyDJzNFVNSY9aJ6mAXXVJi8H0WxRpY4Oyfesiz883yAPIFe4vTdbLMLxijPufODe+OxHCWG3raaCx0bUIpFGbU1Xt94LeCqupMvthzum0kPFaWkDWA3uqgSQuVA4HCOnLqGUoWsBMEQZKIuEIGYnowd/u5IJcity7/sk9uQuFKtLgMa8zwDQqWoieJ4FkbjpoDvWwGVuzh4zRmK7ba
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5884f85b-9c9f-4173-feda-08de7e9a54fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 11:44:04.8654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWCfcZAT2qz5jDun+3ZKTN8HT2Ro6XoVrxjO3YfOPex3o0jdWrGFjJ7sY9RI8hzvr6VWc8OIDLcgQ9zw3OGTowuZX20gblAQ9+cYmq2c8jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8008

T24gMy85LzI2IDk6NTYgUE0sIEpvYW5uZSBLb29uZyB3cm90ZToNCj4gQSBmZXcgcXVlc3Rpb25z
Og0KPiAxLiAgRnJvbSB0aGUgc3RhY2sgdHJhY2UgaXQgbG9va3MgbGlrZSB0aGlzIGlzIGhhcHBl
bmluZyBkdXJpbmcgYQ0KPiBibG9jayBkZXZpY2UgcmVhZCB0cmlnZ2VyZWQgYnkgdWRldi13b3Jr
ZXIncyBkZXZpY2UgcHJvYmluZy4gRG9lcyB0aGlzDQo+IHRyaWdnZXIgZm9yIHlvdSBjb25zaXN0
ZW50bHkgd2hlbiB0aGUgem9uZWQgZGV2aWNlIGlzIHByb2JlZCBvciBvbmx5DQo+IHdoZW4gcnVu
bmluZyB0aGUgYnRyZnMgeGZzdGVzdHMgZ2VuZXJpYy82NDg/DQoNCkl0cyBvbmx5IG9uIGcvNjQ4
LiBJJ3ZlIGFsc28gdHJpZWQgem9uZWQgWEZTIGJ1dCBnLzY0OCBkaWRuJ3QgbGlrZSBteSANClhG
UyBhbmQgc2tpcHBlZCB0aGUgdGVzdCBjYXNlLg0KDQoNCj4gMi4gIEkgdHJpZWQgdG8gcmVwcm8g
eW91ciBzZXR1cCBieSBydW5uaW5nOg0KPiBzdWRvIG1vZHByb2JlIG51bGxfYmxrIG5yX2Rldmlj
ZXM9MiB6b25lZD0xIHpvbmVfc2l6ZT0yNTYNCj4gem9uZV9ucl9jb252PTggbWVtb3J5X2JhY2tl
ZD0xDQo+IHN1ZG8gbWtkaXIgLXAgL21udC90ZXN0ICYmIHN1ZG8gbWtkaXIgLXAgL21udC9zY3Jh
dGNoDQo+IHN1ZG8gbWtmcy5idHJmcyAtZiAvZGV2L251bGxiMA0KPiBzdWRvIG1vdW50IC9kZXYv
bnVsbGIwIC9tbnQvdGVzdA0KPiBzdWRvIC4vY2hlY2sgZ2VuZXJpYy82NDgNCj4NCj4gd2l0aCBs
b2NhbC5jb25maWcgc2V0IHRvOg0KPiBURVNUX0RFVj0vZGV2L251bGxiMA0KPiBURVNUX0RJUj0v
bW50L3Rlc3QNCj4gU0NSQVRDSF9ERVY9L2Rldi9udWxsYjENCj4gU0NSQVRDSF9NTlQ9L21udC9z
Y3JhdGNoDQo+IGV4cG9ydCBGU1RZUD1idHJmcw0KPg0KPiBidXQgSeKAmW0gbm90IHNlZWluZyB0
aGUgaGFuZyBvciB0aGUgV0FSTklORyBpbiBkbWVzZyBzaG93IHVwLiAgSSBhbQ0KPiBydW5uaW5n
IGl0IHdpdGggUFJFRU1QVChmdWxsKSBlbmFibGVkLiBEb2VzIHRoaXMgbWF0Y2ggeW91ciBzZXR1
cCBvcg0KPiBhcmUgeW91IGRvaW5nIHNvbWV0aGluZyBkaWZmZXJlbnRseT8gQXJlIHlvdSB1c2lu
ZyBudWxsX2JsayBvciBhbg0KPiBhY3R1YWwgem9uZWQgZGV2aWNlPyBJZiB5b3UgYXJlIHVzaW5n
IG51bGxfYmxrLCB3aGF0IG1vZHVsZSBwYXJhbWV0ZXJzDQo+IGFyZSB5b3UgdXNpbmc/DQoNCkkn
bSB1c2luZyBhIHpsb29wIGRldmljZSBwYXNzZWQgdG8gYSBWTSB2aWEgdmlydGlvLWJsay4gVGhl
IHpsb29wIA0KY29uZmlndXJhdGlvbiBpcyBqdXN0Og0KDQplY2hvICJhZGQgaWQ9MCx6b25lX3Np
emVfbWI9MjU2LGNvbnZfem9uZXM9NCIgPiAvZGV2L3psb29wLWNvbnRyb2wNCg0KZWNobyAiYWRk
IGlkPTEsem9uZV9zaXplX21iPTI1Nixjb252X3pvbmVzPTQiID4gL2Rldi96bG9vcC1jb250cm9s
DQoNClRoZSB2aXJ0aW8tYmxrIGNvbmlmZyBpczoNCg0KLWRyaXZlIGRyaXZlcj1ob3N0X2Rldmlj
ZSxmaWxlPS9kZXYvemxvb3AwLGlmPXZpcnRpbyxjYWNoZS5kaXJlY3Q9b24gXA0KDQotZHJpdmUg
ZHJpdmVyPWhvc3RfZGV2aWNlLGZpbGU9L2Rldi96bG9vcDEsaWY9dmlydGlvLGNhY2hlLmRpcmVj
dD1vbg0KDQoNClRoZSByb290ZnMgaXMgb24gdmlydGlvLWZzICh1c2luZyB2aXJ0bWUtbmcpLg0K
DQo+DQo+IDMuIElmIHlvdSdyZSBhYmxlIHRvIHJlcHJvIHRoaXMgY29uc2lzdGVudGx5LCB3b3Vs
ZCB5b3UgYmUgYWJsZSB0byBhZGQNCj4gdGhlc2UgbGluZXMgcmlnaHQgYWJvdmUgdGhlIFdBUk5f
T04gb24gbGluZSA0ODcgYW5kIHNoYXJpbmcgd2hhdCBpdA0KPiBwcmludHMgb3V0Pw0KPg0KPiAr
KysgYi9mcy9pb21hcC9idWZmZXJlZC1pby5jDQo+IEBAIC00ODQsNiArNDg0LDE3IEBAIHN0YXRp
YyB2b2lkIGlvbWFwX3JlYWRfZW5kKHN0cnVjdCBmb2xpbyAqZm9saW8sDQo+IHNpemVfdCBieXRl
c19zdWJtaXR0ZWQpDQo+ICAgICAgICAgICAgICAgICAgICogdG8gdGhlIElPIGhlbHBlciwgaW4g
d2hpY2ggY2FzZSB3ZSBhcmUgcmVzcG9uc2libGUgZm9yDQo+ICAgICAgICAgICAgICAgICAgICog
dW5sb2NraW5nIHRoZSBmb2xpbyBoZXJlLg0KPiAgICAgICAgICAgICAgICAgICAqLw0KPiArICAg
ICAgICAgICAgICAgaWYgKGJ5dGVzX3N1Ym1pdHRlZCkgew0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZm9saW8tPm1hcHBpbmctPmhvc3Q7DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYgPSBpbm9kZS0+aV9z
Yi0+c19iZGV2Ow0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHByX3dhcm4oImJ5dGVz
X3N1Ym1pdHRlZD0lenUgZm9saW9fc2l6ZT0lenUNCj4gYmxrYml0cz0ldSBpc2l6ZT0lbGxkICIN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAibG9naWNhbF9icz0ldSBwaHlzaWNh
bF9icz0ldVxuIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBieXRlc19zdWJt
aXR0ZWQsIGZvbGlvX3NpemUoZm9saW8pLA0KPiBpbm9kZS0+aV9ibGtiaXRzLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGlfc2l6ZV9yZWFkKGlub2RlKSwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBiZGV2ID8gYmRldl9sb2dpY2FsX2Jsb2NrX3NpemUoYmRl
dikgOiAwLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJkZXYgPyBiZGV2X3Bo
eXNpY2FsX2Jsb2NrX3NpemUoYmRldikgOiAwKTsNCj4gKyAgICAgICAgICAgICAgIH0NCj4gICAg
ICAgICAgICAgICAgICBXQVJOX09OX09OQ0UoYnl0ZXNfc3VibWl0dGVkKTsNCj4gICAgICAgICAg
ICAgICAgICBmb2xpb191bmxvY2soZm9saW8pOw0KPiAgICAgICAgICB9DQoNCkhlcmUgd2UgZ286
DQoNClvCoCDCoDE3Ljg3Mjk1Ml0gYnl0ZXNfc3VibWl0dGVkPTEwMjQgZm9saW9fc2l6ZT00MDk2
IGJsa2JpdHM9MTIgDQppc2l6ZT01Mjc4ODgwNzY4IGxvZ2ljYWxfYnM9MCBwaHlzaWNhbF9icz0w
DQoNCg==
