Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35831258CD9;
	Mon,  1 Jun 2026 05:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780290726; cv=none; b=Q64GXzx7iOwbtRsPGIv3PdKopJs0M4ZRgLjtw5pi58173oDFkP1DZ5P/YKNVdsVxT1HLYuLgWXiueadqDbPMqFQj6ASBy6Z8aTeQ9OsVhfMEyIc0BFIUzVdJpae6pvw0rXRgf9jQIHxvMEeVuq/mYrEoM1rRs6x+QhK6cThrBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780290726; c=relaxed/simple;
	bh=RQUGvqTmw4Ad5VHPwPPgvxBlVO6BZKGHwrCg158WAoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsBb2vN/lI9PoOYWXO3zPIY2KqUqpAOvZn2p+bLpPbsx1/d6yRFRHFSPJD7WffyEl3Wu1neDeDH66u+EHrr//o9CYfx/nMMgyqdsz2BO6P+6WY6WaZSykqRgsVGlouY6s8SUpaNXyQ1+IaEJIvTdqHPJBskNJ3OIl5u2AnOSc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OGlv3KFX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OGlv3KFX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F1091E8D;
	Sun, 31 May 2026 22:11:59 -0700 (PDT)
Received: from [10.164.19.28] (unknown [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 557133F905;
	Sun, 31 May 2026 22:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780290724; bh=RQUGvqTmw4Ad5VHPwPPgvxBlVO6BZKGHwrCg158WAoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OGlv3KFXuql87mAXxRK2wLY/ouQd96qIGs/u3Yob0U0mjEJjADk5z0ldj5rl00HEb
	 1+Gq//BPFSShXsS5qUpW+C6rWTB6+6PPjaVHFqjK3o0vnc+nuaog+TGW8f13/QcZDT
	 rDVLdCmNdPq6SkCJMI1J0nxYMYXSpq0F2j6cPKTI=
Message-ID: <3e1c2b9e-83f2-4740-9a8e-e05f564f37e9@arm.com>
Date: Mon, 1 Jun 2026 10:41:55 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mm/hmm: A fix and a selftest
To: Andrew Morton <akpm@linux-foundation.org>
Cc: liam@infradead.org, ljs@kernel.org, jgg@ziepe.ca, leon@kernel.org,
 david@kernel.org, shuah@kernel.org, vbabka@kernel.org, jannh@google.com,
 pfalcato@suse.de, balbirs@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-kselftest@vger.kernel.org, usama.arif@linux.dev, ryan.roberts@arm.com,
 anshuman.khandual@arm.com
References: <20260530085413.1270139-1-dev.jain@arm.com>
 <20260531122458.864e9deac7425e1b71c14f3a@linux-foundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260531122458.864e9deac7425e1b71c14f3a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/06/26 12:54 am, Andrew Morton wrote:
> On Sat, 30 May 2026 08:54:10 +0000 Dev Jain <dev.jain@arm.com> wrote:
> 
>> Patch 1 fixes a stale warning present from the time when only migration
>> softleaf entries were supported at the PMD level.
>>
>> Patch 2 adds some code into hmm-tests.c which exercises the pagemap path
>> for PMD device-private entries.
> 
> David, I'll retain your ack on patch 1.
> 
> Sashiko has a concern about the selftest:
> 	https://sashiko.dev/#/patchset/20260530085413.1270139-1-dev.jain@arm.com

Same concern as raised by Balbir.
