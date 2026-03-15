Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FAD20299B
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773580345; cv=none; b=H/UokAfzfeu8gdr2Sds8XBtCeC8/dM1ZLtieJtf24T64p3KcG/cxv5wWxhe/YAoGsiaEzhMLUNNt8mNGI15mXXRrpBa7t5BpawzsC0EnsJURRmwl6o0klMPVfIgC4FoCf6w5Izc6CLLmki6/zzYAzT0YIw4gYl78evOSW6U1j50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773580345; c=relaxed/simple;
	bh=3gNzQRdnU3vCcN2PUBYD0NQ9J3vae2VxeRuOByNrWEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmj2YvH59ZtgWV6JpFFKYKjnoGjcjOyrBidsiakeiMq2FMVyEYE9xW44dPKtfqBjMTt+FBMoL8lKZVOA8OQzlLPEeSMwzEz2siLdjgIJUcLQLAOPwPJR0KdM4eWKLp15nttSXBpLnTrhVrYqE2CMPPhmFW3JYsHDPT7vPehIPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o2amTglJ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o2amTglJ"
Message-ID: <0c2bd25d-1577-4935-8ebe-0762b480abfc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773580331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26yBis00uiMPtDS8aUzlNEkKNIcpZ/qQQw/Qafqh+68=;
	b=o2amTglJM3JAnBL6XV4rgGAEVqgVrlFKflEOc3Ws/663wYLicZXtcSTQH/CQ0q1REGRYv7
	mGvwb23SMOEbTqnr41lCerM107hhoFBtbAjKPHTtYT3pQe/gOvLCwEtJ/RqlAFkasmWRHd
	scrDdVGDWCGhUBisO8rX4k/SyQwUvEo=
Date: Sun, 15 Mar 2026 16:12:02 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] binfmt_elf: Align eligible read-only PT_LOAD segments
 to PMD_SIZE for THP
Content-Language: en-GB
To: Lance Yang <lance.yang@linux.dev>, r@hev.cc,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, david@kernel.org,
 jack@suse.cz, kees@kernel.org, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com
References: <20260313005211.882831-1-r@hev.cc>
 <20260315034647.8462-1-lance.yang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260315034647.8462-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 15/03/2026 06:46, Lance Yang wrote:
> Hi Rui,
> 
> CC Baolin and Usama
> 
> It would be better to keep earlier CC list across revisions, especially
> for people who have already reviewed or were explicitly include before.
> Otherwise, they may simply never see subsequent revisions, and from
> their side the discussion just stops there ...
> 
> Thanks,
> Lance
> 
Thanks! Also adding Ryan who did the exec_folio_order() work for ARM,
and also raised good concerns in [1]

The problem is not just alignment for elf, we need to fix more things like
mmap heuristics [2] and how unmapped areas are gotten [3].

[1] https://lore.kernel.org/all/cfdfca9c-4752-4037-a289-03e6e7a00d47@arm.com/
[2] https://lore.kernel.org/all/20260310145406.3073394-3-usama.arif@linux.dev/
[3] https://lore.kernel.org/all/20260310145406.3073394-5-usama.arif@linux.dev/

