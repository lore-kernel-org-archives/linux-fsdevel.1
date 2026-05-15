Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184FE3F889F
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870079; cv=pass; b=MvH8nsFHt+SxjPscZha/oW4u7LnR//ghnEwu432OcH2bi9ZTrDX87nT0h53s117geJ/ZS6oruW9yJv41v6ksv5lXZrpoGnq6R2NbqCctYE+sIt2khkkCIe4duBCaYCL97lSfRW6EVHYkjkkYGeZk6C6gRtJpb7SUqrtZ3hsANAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870079; c=relaxed/simple;
	bh=DA2Wy9smkUrOgGLD5EcQ7iMKHSUE3cp9ttCFreanAWA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBnNYRbUP+xuVmUO/ZLO0btFYtDEy3jTpu+Urd1sxWXpwPDilAx42FWjg4XFdPUcldnZGR5Hp62ZrpB0yw4KRxZRFV0hvCvPkXPMI9J2q5UNShlcboPHQriSCrLtZLSnL5od+VOZKz5kNZgMQ6SVMugpcixFvphxNaUfc/QJdVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYS73nz/; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYS73nz/"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9568159ee07so27014241.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 11:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778870075; cv=none;
        d=google.com; s=arc-20240605;
        b=WzadZLykWXJAeaAJN53Xz32HOagyAKp+/j2gdqVvrOBKI72IyjjXYjfBiGJhbJCE5k
         COj2vHh8yJfEfF4SGFfwBvyr67U0yboyz9IMomFFENujess2/ZND0wY1rOfpyBOwftQE
         tzRsvPsyg4zTzsiD1SHWJ9Otm2PPU0rARx4Gth9szILTLYjI9CHs0JKnAHNODqC/8Qr3
         I30yuWe7OJagPHvSHUOc4Wz6q+6HJMkF7xOXm9GWOa14QV9GwIHU4Ic9PmZLz0cIFjfi
         q2F2gfq0gv5i41oMArOpop0F+/siie0Doyc2uly+WkfXESuCPo/8+9vKWNyfq9SnZqei
         X6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=hXzcL4Si7AoDz7U9pqlgIyMQAxFIyNef25XFajpPNe4=;
        fh=wr8jABeZcZ3HaB4qgr+Tfjs9X9KZHois6NQYH7eitQ4=;
        b=UiOOxKtFKXW4TXmCi9OmbMO/Nr1Q7PDsCWujIATHNEvZmGivi2ggbh9ShVp5iaRlag
         bESLT2/K+OJ/H+soH4oBQMhbcOEFhMF/DqiOQ2S++SFDIBjkemVRNJp4fEKSUAE0xUd7
         oMpwx1MxefYmyAci4o1NlTFJnrJNzwxMCbaZYYxg88e0rUdHZt6RduzxwnDNc3UzUYvu
         9t8Sv4xF1kiXy4idhhkzPgnXwq8pxUq4RBj+EM5Gzh8cL82UV5AScNJ1pPls+zFYx5AE
         s2jmK0LeVADnzli4Vh5pnnLCRWKXiFDgHvMqJFyiFJ7mCrlopGh+xaXEztH717YSfYxw
         RfbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778870075; x=1779474875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXzcL4Si7AoDz7U9pqlgIyMQAxFIyNef25XFajpPNe4=;
        b=YYS73nz/xIcDnIoNXHbg5GJ4s1o3X29GnkFEut9rfuxgQk3TQRUsu6RVLw+uqTtc/v
         d2z1AxB2eSs4RV3oGINb/D2mPrEtUN+TCkSDpWobhMFO0HR0hbo5L8yeD9O8iU/IcRJH
         sa7VwaOXROWEEexJ+1HCXnKsA1naMryFUYh/MiAvcrarKYPHzupdMRSlAWyR8eOetR3b
         Sxe8w+/PVbeVsIw96r/jOUejGQ71sBO0mVt543KBlOXhuQ8VzTtMl4oO9u8I8KxBxyia
         EK+Q8RFlfe1ZHyYZaqOa1j0zPOMaJsKMfLjG/nF5Rn7Z23Kd8k2b0hBAblYntqprLt5m
         Klbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778870075; x=1779474875;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXzcL4Si7AoDz7U9pqlgIyMQAxFIyNef25XFajpPNe4=;
        b=sGsXCwBeS9P+pCAFNxwc9DpliGW3UHuU2jQ47SLzLiyWW2bSRVF5fl9P9vVpbIuHAW
         PvO9JAgCvOIZgeGoSnX9u7LI8myBeCvoPynMODMUS9jjwcP+KrNABUKZabp/gBAeldQ8
         tgqRDTzQNXtPNg9tqw4jEMPkUPTapbzly2MsglT5Cw8ZITWhbOnRo094AvtqPSzXRV6h
         xiS67Jyi0oB5TZan404rdkwGLQIol3JIz4Nimp0J1uGLmwaUMprwYp72OgklOAB/ynh8
         z1z/V0t2dGCfMAJ9iDxBPfdQrERByo7BZHYc3khSPzvrazew266DIEDE8knFpvLaMxYX
         L8AQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qTx6cI3q88+LMjbBWfyRct3BFQEgYNnCbVmxzuoeqY0Asb+lWtamtIBVp5h2wyi6knIBjO67yXSV5t0Yy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6tNRzdbpo14KgvUEkgfUYmyUEV5x8yZpEUnjUWzFNDuBH4Y/T
	1yqp7ylXA7IGbGqIjnidBpWVreyQHmXE+d2ycp3grMV1ysXW0zJQYMzC2wT8C6hr4nKC1SAIy9t
	8TNQDJ8OWTOjBGjvN1hf9oZHPLB34DOk30R1sa6am
X-Gm-Gg: Acq92OFZ2TkYKyGyjsXfdvvVczTtKhOqxBZZ2+KeNlRLaHJIXWmANjn/+4EFtT7PSiQ
	su1x1wwdvF6cgODBH8Cu+cjQLKeIT5UL6LIxqXD3VjRbZIZL7rRidYu/Jzt0/LksPDEdCTPqXBI
	BA6+8scsSjwXpU9x0y/RMJ5UeLILr3YZzrf0g4dr1D+aqPv1D5Zs5SNATNIAhUBDKloQ9/egbZM
	d2PdAzjs9WUVlJjUN3bxLAEAzN0Ts8OFybiGcuIO5Jm9fNHTwxIgxg8e5Nt318mEjPW0P6g7Jyd
	A4Sz58ms7NixIJ6/kd/tIQg3Uxyq78MPrevmpbMc6PeINOcY4pqB0/8Iez70jONRW7gleLT9fkL
	9IEo9mGhf5ML30w==
X-Received: by 2002:a05:6102:f13:b0:5ff:f4ae:a154 with SMTP id
 ada2fe7eead31-63a3ca1ab64mr3398396137.1.1778870074886; Fri, 15 May 2026
 11:34:34 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 May 2026 11:34:34 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 May 2026 11:34:33 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ac7oE_1j6gxf8OKT@google.com>
References: <20260402041156.1377214-1-rppt@kernel.org> <20260402041156.1377214-14-rppt@kernel.org>
 <ac7oE_1j6gxf8OKT@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 May 2026 11:34:33 -0700
X-Gm-Features: AVHnY4IEbHvurLDEpAdcz2fUdNtakQtGECOPGI7q3-EkzXTSsmoe5CSHOnLeDQk
Message-ID: <CAEvNRgHd4azPaMddvqnSG+Z5fmg+LWd+pz=LSB3PrJTW618dww@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] KVM: guest_memfd: implement userfaultfd operations
To: Sean Christopherson <seanjc@google.com>, Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, 
	Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, 
	James Houghton <jthoughton@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Oscar Salvador <osalvador@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, tarunsahu@google.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
>> +#ifdef CONFIG_USERFAULTFD
>> +static bool kvm_gmem_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
>> +{
>> +	struct inode *inode = file_inode(vma->vm_file);
>> +
>> +	/*
>> +	 * Only support userfaultfd for guest_memfd with INIT_SHARED flag.
>> +	 * This ensures the memory can be mapped to userspace.
>> +	 */

Is the principle here that any memory that is allowed to be mapped to
userspace can be userfault-ed?

>> +	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
>> +		return false;
>
> I'm not comfortable with this change.  It works for now, but it's going to be
> wildly wrong when in-place conversion comes along.  While I agree with the "Let's
> solve each problem in it's time :)"[*], the time for in-place conversion is now.
> In-place conversion isn't landing this cycle or next, but it's been in development
> for longer than UFFD support, and I'm not willing to punt solvable problems to
> that series, because it's plenty fat as is.
>

Thanks :)

> Happily, IIUC, this is an easy problem to solve, and will have a nice side effect
> for the common UFFD code.
>
> My objection to an early, global "can_userfault()" check is that it's guaranteed
> to cause TOCTOU issues.  E.g. for VM_UFFD_MISSING and VM_UFFD_MINOR, the check on
> whether or not a given address can be faulted in needs to happen in __do_userfault(),
> not broadly when VM_UFFD_MINOR is added to a VMA.  Conceptually, that also better
> aligns the code with the "normal" user fault path in kvm_gmem_fault_user_mapping().
>
> I'm definitely not asking to fully prep for in-place conversion, I just want to
> set us up for success and also to not have to churn a pile of code.  Concretely,
> again IIUC, I think we just need to move the INIT_SHARED check to ->alloc_folio()
> and ->get_folio_noalloc().  And if we extract kvm_gmem_is_shared_mem() now instead
> of waiting for in-place conversion, then we'll avoid a small amount of churn when
> in-place conversion comes along.
>

I think it would help if we do some refactoring of existing allocation
functions to provide guest_memfd's uffd ->alloc_folio and
->get_folio_noalloc callbacks instead of having new functions.

Perhaps uffd ->alloc_folio and ->get_folio_noalloc can call an alloc
function refactored out of kvm_gmem_get_folio(), and also do the
kvm_gmem_is_shared_mem() check.

+tarunsahu@google.com, who is starting work on guest_memfd preservation
(as in LUO/KHO).

>
> [...snip...]
>
