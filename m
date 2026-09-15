Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5687199920
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 05:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449595; cv=none; b=N1EB+5SFdLXwXe5RMbDUjM4iuvbmmxjFiEa2aiO8KV6iY8ESC+X7kIrS2MP9z4ZN3FnUEo+4B8xL3DZvVgWFYWdH6w+9BX+mPqfZgrAYhW/F8zqf9GpGpfFswtiBpt61ASrnsNHdsoqAsCoS3C2UGqRNL+I2PRPu2X53X/21Aig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449595; c=relaxed/simple;
	bh=gNcrHum2h1i2kbH/WlpN4W1849JxGf0TTmLYcZ1KnuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBVBaC92Ojbiulw7pIG4hNzsUTteAGtB3y89P/esKVMzXq1XzOjFoLx5t61MK3UQq9kNu3O12TucwLbI71xwoZHSQGzMo9TAV++eFf/ky/bPyFcCSeL6xXQzf4PGXdNeFYJEX3ekqls8fz2JuoRWYEt+tA01r3Qwkzkp2YZSyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OUqpzMmO; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OUqpzMmO"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-939fc329d35so246652985a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 22:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789449592; x=1790054392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lEsdiGwvz+hN4Uya5W3W3ek2drBfy1jE28a344uCWRE=;
        b=OUqpzMmO25Fl+87v1LLlDKTdA2kIZn3fmOLs0cVl6ft8sVjpXT41CMWDS08o7LqM5n
         V5HQV6cnszb5CIVbsmv/sDLnantxrZRYXKBt9sJPsJq+F3ZKb8NvsprTxyTkDigYEyhi
         D/xabZGF8685UuBXDxj3BlbqkhfXZa0BIWgVvgF86I0zKgnB8cfPsT757usqTXPdUcgr
         jI3YBPfMEli3BoLzpfwpq3u+VjStd4e+D3a52iRhJUPqWIAU7kzX8tZn+FUoi9AZsQ6l
         o+r2j613A8hFAMItvxjvqKjl8wDj5oisjMMOCg4ywgxTUrMy4YaO+q2OOYs7l/1zULte
         PqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789449592; x=1790054392;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lEsdiGwvz+hN4Uya5W3W3ek2drBfy1jE28a344uCWRE=;
        b=kJV1r3tuLnF/t7VRRk/i9x6atdKqYaZ+uUq987xGWqyFODgeRypv5SamgAswfkXaC/
         aOjVX/6Pz/xhp7EiSuiw3/vzhABo9+uqvZioAYVOPW6IJKAioSiwBkBS6AL3M/qiHmeP
         +a+1NPDOEVqjGyXMjS26/RxBmwppXC/Mb0tlkBz8EEMkWkupIyD3GG7U+gQwdbAbDUzr
         ijtBxHYK9eI8VCzKAgFcpTXi0T9fhDyJpA0VDgDKVWBO/CYlDeV5PeyM+aZ3Tw6+UXnh
         ddoJjcubp1iI2pH013wqvCXPCHiPWsSZyP7odJuPbpI8apNlseNQOD0g2ku6WINNn5fo
         A1pw==
X-Forwarded-Encrypted: i=1; AKwUvBy4nwS1VLCBLv021xNeZl7UZY9NdWme5L9pFxHTivWJJwtieWPzzXX96hW9IWUsMrSoP755y+lS8+6/wEBG@vger.kernel.org
X-Gm-Message-State: AFuF++mcfGxaIpI7kz91Y7IRMnnKRSXyeUUAlT+xzQRnEWsWOkH8gsYw
	HVSMRvQSqjVXTX9ae/WE3iNqTk0QvIYv8R+Ff5+9MqtRlYxtedRL+N2qhGugtF/uWD4=
X-Gm-Gg: AYBFou2mSKjw7VMLPEa8IzLiZcFL9fKUT35vsJBpFemJ6IWL9JAAi7VZKzT/rmh0M2b
	nuKV5LHRu8w4/gaV6r7eWxH/acSN0uOPPohq79UOgICg8CRwKBMgRSoQa1fcANfwUeF71II6Vbr
	IyWPwR2UfADYTIufoaw8InToJKSaor3tCqGcBbKRAx0mRevXkWI7aE9Z+pA9MOs3nD0NqltIj6Z
	LRjO9icwXdvRcN7O0SKXV3mHOZLoixaFK9IYHZ8SA3B1TpUxXrvq88r7oT+YuRq5pG2XVV/gwK8
	OpfQ26pugdfXL3tIS8OIGFYtOQ1du3GwbRl0QmG2xVqdvXTaHUG9x/Q/JHzsaXZ4DVHTrqxyGwx
	d87K21gNHqabaGX5QrShNvRy+6/g28CYFtl8rIFlizwWoyDpM47qa30RNGUMqyvz1ko1nbOZVJh
	cQYqHjBZI05onMw5uFdFmLxgFWyBU2f+xeGvLMTl3w4P8nw7QLnAyePHXR9lPAkmTjMsbBgJBrj
	Tx4u7KJxiL/bPRbZG6u9hV+yfB78/LDT9WDKEXL/QDGao/QdwOMqFU=
X-Received: by 2002:a05:620a:45a9:b0:936:576e:227b with SMTP id af79cd13be357-93a29939976mr829769385a.24.1789449592537;
        Mon, 14 Sep 2026 22:19:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e811b572sm1191802485a.47.2026.09.14.22.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:19:52 -0700 (PDT)
Date: Tue, 15 Sep 2026 01:19:50 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, jannh@google.com, pfalcato@suse.de, peterx@redhat.com, 
	jgg@ziepe.ca, david@kernel.org, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] proc/task_mmu: handle special PMDs in clear_refs and
 pagemap
Message-ID: <aqjS0xWes7fhhI9A@gourry-fedora-PF4VCD3F>
References: <20260912122822.3348978-1-gourry@gourry.net>
 <20260914214910.a22cfcdc250bfbb6b14edaf8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914214910.a22cfcdc250bfbb6b14edaf8@linux-foundation.org>

On Mon, Sep 14, 2026 at 09:49:10PM -0700, Andrew Morton wrote:
> On Sat, 12 Sep 2026 08:28:22 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> > mshv_vtl_low can install a special PMD from a PFN supplied in the mmap file
> > offset.  That PFN need not have a memmap entry.  Reading /proc/PID/pagemap
> > or writing /proc/PID/clear_refs for such a mapping oopses the kernel.
> > 
> > With a test driver mapping the PFN at the 1 TiB mark:
> > 
> >   echo 1 > /proc/self/clear_refs
> > 
> >   BUG: unable to handle page fault for address: fffffb5b80000008
> >   #PF: supervisor read access in kernel mode
> >   #PF: error_code(0x0000) - not-present page
> >   RIP: 0010:clear_refs_pte_range+0xb1/0x1e0
> >   Call Trace:
> >    walk_pgd_range+0x50a/0xad0
> >    __walk_page_range+0x6a/0x1d0
> >    walk_page_range_mm_unsafe+0x193/0x230
> >    clear_refs_write+0x18e/0x3f0
> > 
> >   pread(pagemap_fd, buf, 512 * 8, addr / PAGE_SIZE * 8)
> > 
> >   BUG: unable to handle page fault for address: fffff57840000008
> >   RIP: 0010:pagemap_pmd_range+0x3cf/0x6b0
> >   Call Trace:
> >    walk_pgd_range+0x50a/0xad0
> >    __walk_page_range+0x6a/0x1d0
> >    walk_page_range_mm_unsafe+0x193/0x230
> >    pagemap_read+0x1dc/0x350
> > 
> > clear_refs_pte_range() passes the PMD to pmd_folio(), while
> > pagemap_pmd_range_thp() uses pmd_page() followed by page_folio().
> > 
> > Both paths assume the PFN has a struct page and dereference bad address.
> > 
> > Use vm_normal_folio_pmd() and vm_normal_page_pmd() so clear_refs skips
> > folio operations and pagemap skips folio-derived flags for special PMDs.
> > This matches the PTE paths, which already use vm_normal_folio() and
> > vm_normal_page().
> > 
> > Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
> > Cc: <stable@vger.kernel.org> # v6.19+
> 
> Why cc:stable?  Is a crafted test driver the only way of hitting this?
> 

Technically reachable via mshv_vtl_low, so i tagged it stable.

It's hard to make a judgment call on some of these - so I err on the
side of backporting.  Feel free to drop stable if you think it's not
worth it.

~Gregory
