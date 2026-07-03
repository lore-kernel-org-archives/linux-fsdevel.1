Received: from mail.ekdawn.com (mail.ekdawn.com [46.225.164.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF03B27CC;
	Fri,  3 Jul 2026 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.225.164.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071068; cv=none; b=hoXuFp6/kNmFe3IQuK4VHZ9dZ++AKM8T3i4AAd8iJxmYl1a6kQg38nCHAOTq8v38gBmWSva9tvvFfRYtt+/epptalvUQUjmT6F2odOnFXI67ZYoe0OjSTkvJAWtYLVg9UWUC6R4qQDIdQ1TQQpi71M/RTvbkEDdnxPETzm/ptvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071068; c=relaxed/simple;
	bh=D3imulWv9RUeQTwUgvoIo8iOKWXUvpeew+2rPBCYZus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmwXopbvEo6zMPAYbAzeIDRoUveFGoiE11PSJCZzmG+9imGRCSgFFKQy4rpzMiD/n8LXMQzTo7fAplUsiyKLiZsvBzVbKU5YjRQf6U5hL6C8gw09vNX354Jn3aje/2FwrgfVoq3if4BDTxkKcA3OGtJQxVv3ECU4hevUZxHTP00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=horse64.org; dkim=pass (4096-bit key) header.d=horse64.org header.i=@horse64.org header.b=nIAl3Jpr; arc=none smtp.client-ip=46.225.164.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horse64.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=horse64.org header.i=@horse64.org header.b="nIAl3Jpr"
Received: by mail.ekdawn.com (Postfix) id 74F671E0048;
	Fri, 03 Jul 2026 09:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=horse64.org; s=dkim1;
	t=1783070490; bh=D3imulWv9RUeQTwUgvoIo8iOKWXUvpeew+2rPBCYZus=;
	h=Message-ID:Date:Subject:To:Cc:From:From:Sender:To:CC:Subject:
	 Message-Id:Date;
	b=nIAl3JprrsOPTRzd84n/HsB0UDubDEg/syplYSv0tyqvosddGMAOJ+skzPu9ccAmF
	 R5koCsJAKV60FwrdBYoz8DpC/heL9pPs9sieclHl161fGmzRKl2FRrqpod3JsktVVm
	 ZjfljiaUoRzyKzTwLS+ASQOQVqZl2KWVm+nAm/j00OThGKe61eVDSjkxdqrBivCgYl
	 BuSg0+X+l6JGWL6u3Pn0dNCMCIMbYicXt0XzI65kvW3e7E5fHXzl4PZgzoqH4AzJr7
	 +XMq+bBxdEQDe2nS8kdG2kMU/yEexIinG0B2VboTdEBLueTkLZ+aZp/2z0xj1F8KDH
	 Cu/vCLxcDeXKuhUwFErk/vKlDdeH+42RXPN8rnMbTEihs0hcWdr3beB50ia/RlSvAD
	 Ngpcl5NBzu0RnTsBiEQPOaC44O1h8ENDFv1PCQ14jufsnEYVjFaFFn6OiH5b3dSKIQ
	 fpCrdOYl3aMmhpIBFjuDpAJ0TWU0ixo7LbboBza9y/PDVU13Pir/buaScHLbJfXbVy
	 k4MU/OXc6ej8Oyu/2J6o0hyqHD9dZ8wiexGy1ca+h80TSLZwMQ3gNdTumKf11e87UO
	 XSoiDx1RRZmHv4GxJ/QndtuRq1RdbuXa3zzBepoGgzyL+r8nJtmLec3EimUlD44twV
	 6cpZyxiSSR4vBgTXDD/qhz/0=
Message-ID: <53942438-a44d-4578-b1c6-d45c2af1767d@horse64.org>
Date: Fri, 3 Jul 2026 11:21:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Jens Axboe <axboe@kernel.dk>, David Hildenbrand <david@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
Content-Language: en-US
From: Ellie <el@horse64.org>
In-Reply-To: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/1/26 5:54 PM, Christian Brauner wrote:
> I remain very confused by our coding assistant contribution guidelines.
> I'm going to be a bit polemic now but this seriously in good faith.
> 
> Why precisely do we require all this detailed information about what
> specific coding assistant was used?
> 
> I find it very irritating that our git history has effectively started
> to function a bit like a free advertising platform for a bunch of AI
> companies and their proprietary agents and models.
> 
> And it reamins unclear to me what exactly we do get out of this detailed
> information: Do we want to run statistical analysis on what agent and
> model is used the most and publish that on LWN at some point?
> 
> I acknowledge that my stance is even more radical: imho we would just
> stop it with any disclosure requirements completely.
Sorry to drop in as a relatively uninformed person, but it seems like 
the following mails would be relevant for that discussion:

https://lore.kernel.org/lkml/e12330b9-c29e-45ca-9375-9e3d13426d85@horse64.org/T/

If LLM code were no longer committed to the kernel, which wouldn't 
exclude using an LLM to pinpoint problem spots and security bugs as long 
as it's not used to produce the fix itself, then the commits also would 
no longer need an attribution.

Regards,

Ellie

