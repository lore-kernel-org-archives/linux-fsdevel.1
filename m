Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F23EEAEA
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533432; cv=fail; b=f0g9TW+uV5Pn3W89nobZyjoG/n4EgMmB0HKvpbel+8MSVpub/Xpl5mdcQznYQYUinbxuTHgQYdIAlb6RPxiqpdQqAlsmnqOgaeRq7kmSdUY0VSOOoRQ84Lchg4t8TlA5h6oeshmWHuI92R7OtaE7gLwIYP07vVvd8mt7Hy3viJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533432; c=relaxed/simple;
	bh=xrnoil/fNd7xl7Pwz/om3ueMux+2COXRVz9tl85WsOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UGi1/lZG7toVPhRRWg7k7aI7S5YMuPznxQ5uo5LrcFYoISkhpXJM5Tn8shgapE7Dkwr4hITGICR+JdodY5JaUWVmTeMAP3+sUNjZwrffp6/MpjBZI7nz33hkrZn5gHq3I8vEzo6mUK8CBnuHgowxxLv20ywsZN0Bp19HwTBwBwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hq7okuHW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WTCuyVFV; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hq7okuHW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WTCuyVFV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781533430; x=1813069430;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xrnoil/fNd7xl7Pwz/om3ueMux+2COXRVz9tl85WsOE=;
  b=hq7okuHW+YWsqyjpJGBkXgtd8rY1A1oc6NYjQra5npJ+erVAe7tgBzKW
   bc+mTV6VP7EqR3G6Qo0QtbBfICE1fERsDZZk2VbLhnTowy+FHBAUms2a6
   i2vUTg7BUeK95dNfEx5L0pVMruoXZ+oXqyth+nBRzumqvpRkJWtj2uAWo
   qWiX5tsPVPqcCBpaEg/GDSLcknq9NdmT+yiAtzr0w4y1aDik5DBHRNpVq
   cJ8M5YLXJFW55kjdu6hfpjA1KykJuTcbpo9tx4T7+78h//8fTVGOvvFLu
   9YulMVOPFbjLPDf1rfUx3tayD+2lGVwq6M54PCnXwW+wjZJyrm4RMFIaq
   w==;
X-CSE-ConnectionGUID: f06XPE4BTY6qp2HASsw7Kg==
X-CSE-MsgGUID: ekE5D2sQSryy9UlOhknKtw==
X-IronPort-AV: E=Sophos;i="6.24,206,1774281600"; 
   d="scan'208";a="148825613"
Received: from mail-westusazon11010022.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.22])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2026 22:23:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sffLYu1DqnNGKElXCBOIanokd/cPQ7s/kBhVPP6sCcFIpd2bICQG7JFGbxMZwLAw+sVJk1wK6dY+V/rPQTkeKiISeIbTq+55SYp9czzCXuGeOb6ymz6tRabptGHyhi4cZPHsRppgwjKpR0mHeeARoJcELsEGvDcUC8fgegcFDlmbmNVwh52GPXUvYXtCZQQu1y6pXjqTqYGiiqgCd/IdIEQDGeyZuV8lJWDZnmDw/HswmXCAIfUTDZquN4CKiDR8S/RWblwt0xFxOQWYl3cxkH+0Ajvya4i+vnOX2/6+GSjoVKN9Ygu93SYjcu2zs3TvPV4RW7vbgULmRVXDHxPPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4B/ydaJWMSsQy7SArE1LxpDnO+U62UfJryqvoyg0JI=;
 b=tL9kihDG7XAdz8jCRsFjtL3q6LcI5HP/7Lbu8oC0+70ifTLtFT29lbx4SYzyRlUo5Ewgm5obiSbPIKnWmU64Zq52rGRDJ1HdpyWzE+c03tEG7bewrAIgZa8JOC26ZO0WrJyqW8b/hI/2dvQw+uvJdODuys0ThsbflAYNmhf/rUM6F7PBHxSCamTh4SZk6nnJLaEpwTagDfVNepZwY4naMH+UnlyKbYJ3gez9acH08yBwwN/CxG3Qk05cKr3J+/ScLEeJKQ80vJiKr2GLv+rYGSNPRYZ7w/wjRKZYs6gAVguPVxD88t57wu9CUMSSyv2u/jRb7fOaaDtFjepTUSDzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4B/ydaJWMSsQy7SArE1LxpDnO+U62UfJryqvoyg0JI=;
 b=WTCuyVFV+Vrf3WMYoSaSJFln3z/I2EayC7UtkoqOoszwMtSOkbOZZ4DrewaDLRw64dhRlTXtfdsIM//ZwxImZrHzfBOPNNFhMT19rkIi1jq0n8gO4vJpZ3o0n2onME4X499IB0hmF4hanOkugoeLjHwo+JeT8aj2CRM3bUF6vlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by LV3PR04MB9185.namprd04.prod.outlook.com (2603:10b6:408:271::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:23:46 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:23:46 +0000
Message-ID: <babe3ebf-9568-4eeb-b729-b3bcc80bf6fc@wdc.com>
Date: Mon, 15 Jun 2026 16:23:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] fs/configfs: dynamically allocate super_info
To: Hannes Reinecke <hare@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20260613111437.101763-1-hare@kernel.org>
 <20260613111437.101763-3-hare@kernel.org>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260613111437.101763-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|LV3PR04MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 56927ea3-61ab-4610-129b-08decae9b577
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|10070799003|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	x3x3OgMdElUcinvsMYQSXDbH8vMMWclDIE0tIaEtJbTUNvzjUImOosz75uRtvJH8tz8rFaB+dWF7s4gemPyedoDJMxfwIf/kNr1Fa78HZ9DcCfEgHoEwfYxif7fcmIbkT1izdslDK0ezkPLWTQi9LSWOhdyAmvVwyijGzeVPYfx7YxJlagQRgcES1u6KHEar46PgZftYNtz8rlMRbxROEyg+NDRCtukkq/29mD0nF8r6pdhNtKX7HT5aYuvu764z18WGLi2eQB2tXL/mTaE+JGMeleiJW7NeiXBJD88Pg5NO5pIwp9KWUYkuWmXSPyoim64WwqsjvQOxgOhGdL0H1YNGQGzFKJ0oacJXdK5ERem3e43NhV4OWq1oHYjr5DBhra/obj1MBpt24TLaVgmpdttYdcu/9lRg+Q2aKOJJc8cSdZK5T3CA03NELFCx0aVQUjclHUUklhD3ig1r8koj/wfRd7VUpW7bDG3m2gDRoKwjvVPyK5BeOGYzDpzv7pHuUkyej8BsM6RYiICPXW14eAXbXIHb2Kd6u0OgdbTiCe2F17qqTFTMr8ZHTXdcVpf4UVsbCixQRXwA2GesU0n6OBitXQOZq0pbj9ZrSxtEh2L6zqUzfrPdeRoSP6ajrDpCYHAi/lFe7CqG0rpOMG/a+d84e593EVMc5LF+pNZ/uKJVIZCKR+FyY070P6QRqVny
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(10070799003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGFnMnlMSFhjdmFDV0R4QVdobm0rNXRHUHgyT0tKVlNicVNsT2FVN2V5akhU?=
 =?utf-8?B?OGpzMzlicUZrUnpXZ2hOcmpRMFg4cmh0TnF5MStmQTlCVXE5WStGR05aemNu?=
 =?utf-8?B?NGZyRlNyaDVJVHYzMDNGWUM4eWhyUWdMVSticlBsU29Db2tkeEc4M1Q3K2pM?=
 =?utf-8?B?c2dOVlRid3o5V2ZvQm5NTVgzY2UyMGgxaUhXYjV4eFRkWVp0MFJ5V1VReWsx?=
 =?utf-8?B?SHRsamV3ZTg3K2NlQnN4ejI4UFUyUndieGZzSzlrQ3lXSlgra2VibWZUVm1a?=
 =?utf-8?B?ejBDWE5Sd0ljRXRNdk9sblVYR0JCNHRYdkExU0cxV1lsQVZOSndLQ0I0eG1G?=
 =?utf-8?B?Zm5mQkRHK3VNQ1l5WXJaZitReHhmNVQ2emhBL3QyS2FTQXd3ZTArbHI1aVlM?=
 =?utf-8?B?WlN4N043UStxN1g1NjliWmxuTGtLN3ZIMHhPc2JDYVpBL3NrRk4wbE1uenJB?=
 =?utf-8?B?S0lkc0RjMDdvWUpUWDdxbnA1SjM4RWh3U2R0cnMxYWI5T1pDVGE5N3hGblBF?=
 =?utf-8?B?WFpkaEhPRXFyUjVDVWZCVW9aWG5keTZiWU5hWWtuY1kvU1orVlBnWGNXSVdp?=
 =?utf-8?B?TjlqQW8yZm92Ymp6S1IzZWNnT2hMTGoybmRmV0J3QWxMbmF6VHkwcUZHa2Yx?=
 =?utf-8?B?U0Jod3kxSHI4eUFyaTZpb2h0NytsQnRUTjFUdHRQZXBpUnh0UTQvTkdwNlQ2?=
 =?utf-8?B?R1RsNnZPd0NEUk1sMnV2bEEvNGhtdEUzOU5rRityQ2Rid0FmM2YvWGVVeTNT?=
 =?utf-8?B?WFVmREFNYW81UlplWXhHOXErb2l6MkwvOUJ5N1VNRGg0WmExNkJ4cWc5a29h?=
 =?utf-8?B?ZkVxak5mTlJvTE5jTlJFc0dlKy9RT1A0ekxHbWxXQy9UWU8rOER2WDBrbStW?=
 =?utf-8?B?c1BOc25sNHdlczRBN1NCNTBuNkNidm1qM2NkaDZvQ3BTL1h5d3c0bUdEbEtL?=
 =?utf-8?B?dTNHOHc5Yy9nOVF1T2x6UStPYklzSFVDT3BPbnVJNWcrZmNvVzFCZDRZSWIr?=
 =?utf-8?B?RnZiRHk1SDkrclE4a2pYbEI3dzB5YThpM0haYmFYRHFvYUtiSEFaT1BkTXFt?=
 =?utf-8?B?RjdXVDZFT1JZSnVudHB4eVE0VVlHM1VxZmF2eUZodStRRmpvQ2NZZlI1WXZ4?=
 =?utf-8?B?cU16ZnpFWXIvZlY0WmU1c1dFYlFoR01TQWxtNEw1UE5uL2N5WGt1Z2hrRmlr?=
 =?utf-8?B?cmtiQWwzSlkrN1FyZUdXaVdmV3hJbjlRWDU1SHFscEdmQWREeGZwVXo2T0FD?=
 =?utf-8?B?a2swSlhZNDlucDFmSllaV3d6NG5RRXd5bEN0anJhcXNoUzh5bSsxWXRtbllB?=
 =?utf-8?B?cml4UW5ZekVFbU5JNlkraTRPendiRHlSUzFFdElud0ZWOURRWDM5cnNFZFZC?=
 =?utf-8?B?S09pS1EwRHFwbkFaVWx2UC9sWTVnenRsS1dUMVYyQTBsb1NsRy9adkV3aUt6?=
 =?utf-8?B?U2Y0ek5GQWdRVFArV1g3UGRzQVAvdFg2VXE4OVNCVU9BSHl4bGNnS09Fc3F6?=
 =?utf-8?B?RVlQUnp4a0M5MG5FbU5aQzgwMHpoTzVZNTVWcitQTldqT3h5RTdFK0VhRUVh?=
 =?utf-8?B?ZVhNMVJMMVFLZEtXdWlzU2VJN3V4RlNYSVFEMzd2S1lGb0lWRHdGQTVtamYw?=
 =?utf-8?B?NXhnZUl6bmxtL09hNTc3MzU0Ym5UY2d3Z0NYbjQ2bDlWUkNkMWxuL1kzb3kz?=
 =?utf-8?B?eVlaSE5DY0tWMDR1RVRsZEZpTFhUUWRsc1U4cG50dmUxUWY3NkhjUFdQdG9o?=
 =?utf-8?B?UkdSbVdUUWFzZDZHVmFOQU1KZXdwd0lJSUc1RGRkSzRnNWdYS0J3NHo2WWNV?=
 =?utf-8?B?K1l1clcyTmYwVWhJWlhjOENSMy9qcWprZzZpb25GbXcwVnFRS2hmODQ4L2pU?=
 =?utf-8?B?N0t1TUcyQzliWjUrdEtPamJUeHZTMlJRbXhQaHpEMVluTkJoYWlaeGRzTHcx?=
 =?utf-8?B?U2ZCVFZyWkc5T29PRG1KU3Ewd3VuaGtlQVl1Qmo3ZlNtUXhldm1NRnRzaTJE?=
 =?utf-8?B?dWFYRExwQTIzbktyYVRlOERhUlBSWk1abU5RSHlQTXB4d3hMS29oQUlML2Ey?=
 =?utf-8?B?aG9scFlpT2YzVEpjRXBZQ0ZrTWpwcHRoTUliNlFVR0VHMGlkZ05Ta3VqZzFk?=
 =?utf-8?B?WWg1ZlY1c1ZqQ3NBQ3UwREtrV1Z4ME1HQVlaNnl0SjNheWx4cWpOKzUyS1ZG?=
 =?utf-8?B?dXlJcHJRNFlDeFhDc2xrWnpQeG5NNjRXZXpaNWJsYXVONk84Q3VzUFdYYldo?=
 =?utf-8?B?ZUdXSStDa3pSNmVES2U2OXZQdFJSZUczSnNER2tPSWNVQWg0L25Ndy9GQS9m?=
 =?utf-8?B?b2J1bGl5cGtSRzRaYy9HR3h6ZzBxVG40SGx2VGxBYzVXVnV1SkNCbDVnRXN5?=
 =?utf-8?Q?m0YF95i06Rp5nU4JI0QBg7l4G25q3kfVjzSyd3ayqYYCt?=
X-MS-Exchange-AntiSpam-MessageData-1: w+yIVi2CPMoi9g==
X-Exchange-RoutingPolicyChecked:
	CFOqCZcleubFnAcmf/f/0WMy687oTlTB6qefDopiPqPWuZvuPaTKye3d64I0vGzmvhWPxBeVw3hOT8jBhkABjZ5G3to1HifAQ5dvXTNsT1iPNArRv7oNnQ/arqrhTqqTiep0bVEPBao582N9dmhP1x441vGTYVHYK0Lk3ODevH6btfY2qsBifp5vqa5/yK+GymQUtoaaYJzl/WEZijjXcuC6+oN1DImc5gWvPCJnQEA5TCFO7Om1DGo9Ci3pPqNcMta6ikSvp0JSkqvGV9xLejFPq7y7fbYpqfdntrmSBv9jIp7zejN8ehhym1NzbSruF2ieZPVM3X4/0qLjsr7Z/w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/An5tK/jVBzLM2UDpfs7gtOC+fBJ4J/IAePrE10ojfhTgfE6OAMCqsREeiQd5uXBZ2cup5pF6BkQjW7AeG3tc/zivtKv78ycAilO0gC8Rot1CzKgIVJoEVjN6NrGp9z4QhELPd1z4aiRVppxho+w4kEdXqqg13/73XLpL3XQyPSgyKcngRfm0N+N70BuRxT4Vcav66almjLSU/oYlC1MAyb8cxuhZ5gYuuUXzsTOsMs5lPJDIOZ52PdInh7/vL+DprsYHkB12PckdNW/dui/H5OYJAoQSzFKgwJ7DeWzPkK/q4yw0zuanm5mRabBc9u2HmJ07fowy2TeWLk4vJESc/ckLOuNToEPdliGFhVDXjh4J6FtbuLP7ZZZx2yJ26r0Q9YfXCpAJQa9nBX7ut4loGbMiqtyR/cZW/byVjfbhlcCkMjbOkxkLTfP4B9k1b56/aZnctSUR4u6aWOBlCAXQ92rQ9riSZujs7gyPYnNVnlh5cuDeHOyd0uPwldK8ZPqynhHH1+0ZBnW9yYfh9R0xPmF+YELzqoebiC5Uo743V7Os7huX3FmX/g8CrUA29aDan4P2erGwFDKdgfGMmfJstiKba/UNp64Np2egx/OenRL5jAJD+XxMz3WJGDdxFFo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56927ea3-61ab-4610-129b-08decae9b577
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:23:45.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HZrKPOzRw7WWqQ/WVJNNBJyJ7Xnvmfig/0KPvBY8a+kKfC0OABo8EaTluiAHhb5bda3vh+6WX/SmyUIRCYqlsn+8siX37j9iljr8DrzJto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9185

On 6/13/26 1:14 PM, Hannes Reinecke wrote:
> +		if (!refcount_inc_not_zero((&info->ref))) {
> +			pr_warn("%s: ns %llu already freed\n",
> +				__func__, ns_id);
> +			return ERR_PTR(-EBUSY);
> +		}
> +		pr_info("%s: use ns %llu\n",
> +			__func__, ns_id);
[...]
> +	pr_info("%s: alloc ns %llu\n", __func__, info->ns_id);
> +	return info;
> +}
> +
> +void configfs_put_super_info(struct configfs_super_info *info)
> +{
> +	if (refcount_dec_and_test(&info->ref)) {
> +		pr_info("%s: ns %llu free fs info\n",
> +			__func__, info->ns_id);

Left over debug prints?

