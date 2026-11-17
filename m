Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928270;
	b=oSaVUfYbYxs1tLaPwBccYa7mUprZVzTSrCjQVfX27UVy6a2ss+Mo/ZYmVbEolDwq490F
	 Q11/gwBau69NeLf0VRhcI8DK0DPS+TOEsyGF/p2A/415FjbnEZZaKIbZNKIy3jjQaCa/f
	 2KK8xNqTw9m2Z8NG7iSWvdIB7WW87apHDhU3sE0JvoepVxMIvSUwjRI0U/vtx7/dI849R
	 qTn6xMFpiVXQaqNzOAvrTQ8VcEsT7k4MqPCMzNg5OK+NLDgACIdxCiP6czk1FTiWFPSCo
	 5GxZD1SglpRsqqdHHYpxl6lF6VbaMMkfojP9B8unvOCVQ8QDcN1MLNzP7/DtUAsQtyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928270;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HArLExOPkNyBYfmrLg8Y0BuhPejqIaFeng7leCdluOU=;
	b=kPGRmNgHr3JQdZwOyvByu4inBhu7tEJ5GwOu5Ji5pyR98q3HWXbSOwpArH61u2GHtwTk
	 G2zRYs6zYV++LoNvmQmE+lx3RME+nU/GSsk7E4/aCYlx+UjgwmqK9xTyBGbZJ3jZXFovH
	 MgQMC8HF+HQNqrj+eBS85NMmkPqhRgPvuaQZYUioG1YXAtAYgzNX5HoBlqni/tSFpFKvo
	 bYzQHxG4t5qZkJ/5u4S36XV+fXfAvfowcnkCV634t3FgK8yzEcwP2Vdgp45KxLuTCCNon
	 zrG0Dn9HVt/KbX54hesMK1ADXJuIcL0mUEFdJDkSzV02QMRxpNo+NDYv5riQtcXYwSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0VaXLgh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E8606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0VaXLgh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176271F000C7;
	Tue, 17 Nov 2026 15:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794928270;
	bh=HArLExOPkNyBYfmrLg8Y0BuhPejqIaFeng7leCdluOU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=P0VaXLghcsMkwQaIOkwnz/GtT6w9pB0/ADDe33yVXJthJhDmoDsT/W7FdlRHHa71s
	 t4g8eOpbVtynxk6GPeqicBefe5+x5HMU4peush2zh3L4GMw+l+F/6+raC2xW4IL/7C
	 g8Mf1fhSDH9l+bhvlcwpSWvIy5rXb3rlJpIfdnflcjCVlj0z7Y+IhLW6+wI5dnu6V2
	 d7IbH9m5uMIDtKJ8uzoLNHAqjvHmSopGMyRWYp/UFvVov0gStSu47vl5ny3bAE3eO8
	 z0ZZcZMzkaLk9yCSb772Pw6AEKGktSa8plrQpVB1MqTJJXWzIrXDu57y2Kbr9jRMa7
	 UVpzn06A10tiA==
Message-ID: <14e28b99-12dc-4000-a704-8b46cfeb3c0f@kernel.org>
Date: Tue, 17 Nov 2026 16:11:00 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH v3 04/10] powerpc: kvm: allow flexible PAGE_OFFSET
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 linux-mm@kvack.org, Crystal Wood <oss@buserror.net>
Cc: Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Linus Walleij <linusw@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Malin Jonsson <malin.jonsson@est.tech>, Matthew Wilcox
 <willy@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Nishanth Menon <nm@ti.com>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
References: <20261116124832.662455-1-arnd@kernel.org>
 <20261116124832.662455-5-arnd@kernel.org>
 <afebfaf5-f3ee-4234-875d-e5ebf1ee64fd@kernel.org>
 <83495d02-4e09-40f0-94fe-e57a1e73d1a3@app.fastmail.com>
Content-Language: fr-FR
In-Reply-To: <83495d02-4e09-40f0-94fe-e57a1e73d1a3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/11/2026 à 23:54, Arnd Bergmann a écrit :
> On Mon, Nov 16, 2026, at 14:38, Christophe Leroy (CS GROUP) wrote:
>> Le 16/11/2026 à 13:48, Arnd Bergmann a écrit :
>>> diff --git a/arch/powerpc/kvm/book3s_32_sr.S b/arch/powerpc/kvm/book3s_32_sr.S
>>> index 6cfcd20d4668..0d8a7857f2bd 100644
>>> --- a/arch/powerpc/kvm/book3s_32_sr.S
>>> +++ b/arch/powerpc/kvm/book3s_32_sr.S
>>> @@ -113,8 +113,8 @@
>>>    
>>>            li      r0, 4
>>>            mtctr   r0
>>> -	LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * 0xc))
>>> -        lis     r4, 0xc000
>>> +	LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * (PAGE_OFFSET >> 28)))
>>> +        lis     r4, (PAGE_OFFSET >> 16)
>>
>> This is not enough I think. You need to load ctr with the number of
>> segments you want to populate. Here above it is hardcoded to 4.
> 
> Ok, trying this one now
> 
> --- a/arch/powerpc/kvm/book3s_32_sr.S
> +++ b/arch/powerpc/kvm/book3s_32_sr.S
> @@ -107,14 +107,12 @@
>          KVM_LOAD_BAT(2, r9, r10, r11)
>          KVM_LOAD_BAT(3, r9, r10, r11)
>   
> -       /* Restore Segment Registers */
> -
> -       /* 0xc - 0xf */
> -
> -        li      r0, 4
> +       /* Restore Segment Registers, assumes PAGE_OFFSET is segment aligned */
> +        li      r0, (0x100000000 - PAGE_OFFSET) >> 28

Fine, thank should work allthough I would have used 0x10 - (PAGE_OFFSET 
 >> 28)

>           mtctr   r0
> -       LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * 0xc))
> -        lis     r4, 0xc000
> +       LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * (PAGE_OFFSET >> 28)))

Maybe an opportunity to replace 0x20000000 by SR_KP

> +
> +        lis     r4, PAGE_OFFSET@h
>   3:      mtsrin  r3, r4
>           addi    r3, r3, 0x111     /* increment VSID */
>           addis   r4, r4, 0x1000    /* address of next segment */
> 
>>>    	/* Restore host IVPR before re-enabling interrupts. We cheat and know
>>> -	 * that Linux IVPR is always 0xc0000000. */
>>> -	lis	r3, 0xc000
>>> +	 * that Linux IVPR is always PAGE_OFFSET. */
>>> +	lis	r3, PAGE_OFFSET >> 16
>>
>> Maybe use PAGE_OFFSET@h instead of PAGE_OFFSET >> 16.
>>
>>>    	mtspr	SPRN_IVPR, r3
>>
>> That's probably valid but wouldn't it be more correct to use
>> interrupt_base@h as in head_44x.S and head_85xx.S :
>>
>> 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
>> 	mtspr	SPRN_IVPR,r4
> 
> Ok, copying that version now:
> 
> --- a/arch/powerpc/kvm/booke_interrupts.S
> +++ b/arch/powerpc/kvm/booke_interrupts.S
> @@ -229,9 +229,8 @@ _GLOBAL(kvmppc_resume_host)
>          mtspr   SPRN_PID1, r3
>   #endif
>   
> -       /* Restore host IVPR before re-enabling interrupts. We cheat and know
> -        * that Linux IVPR is always PAGE_OFFSET. */
> -       lis     r3, PAGE_OFFSET >> 16
> +       /* Restore host IVPR before re-enabling interrupts. */
> +       lis     r3, interrupt_base@h    /* IVPR only uses the high 16-bits */
>          mtspr   SPRN_IVPR, r3
>   
>          /* Switch to kernel stack and jump to handler. */
> 
>>> @@ -115,7 +115,8 @@ static u32 get_host_mas0(unsigned long eaddr)
>>>    	mtspr(SPRN_MAS6, 0);
>>>    	mas4 = mfspr(SPRN_MAS4);
>>>    	mtspr(SPRN_MAS4, mas4 & ~MAS4_TLBSEL_MASK);
>>> -	asm volatile("tlbsx 0, %0" : : "b" (eaddr & ~CONFIG_PAGE_OFFSET));
>>> +	asm volatile("tlbsx 0, %0" :
>>> +		: "b" (eaddr & (rounddown_pow_of_two(PAGE_OFFSET)-1)));
>>
>> I think this is not valid.
>>
>> With PAGE_OFFSET equal to 0xc0000000,
>>
>> Before:
>>
>> eaddr & 0x3fffffff
>>
>> Now:
>>
>> eaddr & (0x80000000 - 1) = eaddr & 0x7fffffff
> 
> I'm probably still misunderstanding the intention of this code then,
> my reading of the comment was that both 0x3fffffff and 0x7fffffff
> would be valid choices here as both are below PAGE_OFFSET and
> large enough to alias the correct set.
> 
> What are the actual requirements for the mask?

I'm also struggling to understand this so I might be wrong. My 
understanding at the moment is that here we are looking for the physical 
address matching that effective addr in order to find the 1:1 MMU 
mapping. The particularity of booke is that you cannot turn off the MMU, 
so to simulate MMU off you have to have a MMU translation to translate 
logical address 0 to physical address 0.

Therefore IIUC the correct calculation should be (eaddr - PAGE_OFFSET)

I guess we need some feedback from Scott Cristal Wood, but I have not 
seen this person recently on the lists.

> 
> Thanks for looking at these bits in detail, I'm quite out of my
> comfort zone here, especially with the book-e stuff.
> 
>          Arnd


Christophe
