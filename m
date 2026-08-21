Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C419D89E;
	Fri, 21 Aug 2026 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341425; cv=none; b=knhhXnlrMxrBvfx0F5IIWX9XiWDeNrGGgnXL8TaYM+vvzsJBqxgRROdaHb4D4sY8oKEMB2mHb1L+nSd0PWLvxqO5Ppj+EO42kQEUYFPdS0BX3P9z8wdjMm/PbRi96dKlsIb0iXMbD5TnPr7e/xi9yYBFAnO40jhJHOP1Oz1Gd6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341425; c=relaxed/simple;
	bh=WTfIypLeHYGeA5nm6xuw+xhMDvUGe64DxBnETBgKxFI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mGHg+ddkXzMbe7zPu5hYA6fd9imGFGu5ncINCCiTKh4qMJLVnkGg+DX0Og9MeEY0DOzVFp3hB2+mHpa7QobMHP2fSSFOLAM5Xh3+uqSSWYFLWB+5/f6cXhHvyy1HS1uxD0vz2Zoyg364T37U1J1x3zfGDs1hxeqai+lah7C0h+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=UOnKEwpA; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="UOnKEwpA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3cuOCLoydud/Ghe+/9rUSZTIFvtw+XcphcGGyMAn1DU=; b=UOnKEwpA8W47dATxIYHpCwlglm
	j4OWzlHUpBHdblDB3DgM+AINW95cU3xyMHpn7Fklf6Jw0KIwvusAjWUVz5slYDNAWJEP898gssApf
	lPX78bB3RKwn9jXCnQE220o4PPErwSQpjtxhshKpHyQLzYg5YrQa5QDCgTQE1MLLVbxb2+j5kwd/B
	GF+Xrj8jZyAjbz3bGywWiR5VYKhZoQpN2ZPHAK3KsRLdowFg5hrcfQ6KnGJQwbtjmWISM9Rp5hjM9
	5sEvcrw+gbEWnVbRhTcxqwufFylrTO+Unnd0apooj8W7MgqkwCzwaoYI5NpwHMdlm6DPKPXs+Bmti
	rDowhHGg==;
Received: from [::1] (port=52878 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.99.5)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1wxV9S-0000000DuUZ-4BGv;
	Fri, 21 Aug 2026 21:43:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Aug 2026 21:43:41 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: kees@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf_fdpic: reject PT_LOAD with filesz larger than
 memsz
In-Reply-To: <aog5Kx6HB3jxb8cJ@lt-jori.localdomain>
References: <20260820222824.3165092-3-Jeremy.Jean@oss.cyber.gouv.fr>
 <aog5Kx6HB3jxb8cJ@lt-jori.localdomain>
User-Agent: Roundcube Webmail/1.6.18
Message-ID: <f7380c43c8cb88cafa170faec902c1b7@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello Jori,

On 2026-08-21 13:45, Jori Koolstra wrote:
> On Thu, Aug 20, 2026 at 10:28:26PM +0000, Jérémy Jean wrote:
>> The ELF specification requires p_filesz to be no larger than p_memsz 
>> for
>> PT_LOAD segments.
>> 
>> elf_fdpic_map_file_constdisp_on_uclinux() sizes its contiguous 
>> allocation
>> from p_memsz, then read_code() copies p_filesz bytes into it. A 
>> malformed
>> segment can therefore copy file contents past the allocation on NOMMU
>> systems. The direct-mmap path also subtracts p_filesz from p_memsz 
>> without
>> first validating the relationship.
>> 
>> Validate every PT_LOAD immediately after fetching the program headers.
>> This covers both executable and interpreter headers before
>> begin_new_exec() makes execution irreversible.
>> 
>> On RV32 NOMMU, an ET_DYN with an 8192-byte p_filesz and 4096-byte 
>> p_memsz
>> copied a marker from the second file page past its one-page mapping.
>> After this change execve() rejects it with -EINVAL, while an 8192/8192
>> control still executes.
>> 
>> The flaw dates back to the driver's introduction in the pre-git 
>> history
>> tree introduced in v2.6.11 by 91808d6ebe39 ("[PATCH] FRV: Add FDPIC 
>> ELF
>> binary format driver").
> 
> I came across this about a month ago. But I wonder if this is even 
> worth
> fixing. You are on a non-MMU system, so running a malicious ELF kinda
> means gameover anyhow, doesn't it?

Well, this would act as defense in depth, no? I agree that cases where 
this
matters are probably rare, if any, but I don't see why this should not 
be fixed
anyway. Isn't it best not to assume anything about the use cases? The 
patch is
only a suggestion to start discussions: I'm merely raising this to your
attention but you guys (maintainers) are obviously in the best place to 
check
whether there are better options.

Regards,
Jérémy
