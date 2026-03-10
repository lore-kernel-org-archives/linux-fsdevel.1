Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215043D51D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133985; cv=pass; b=M0OF3ucssVGhTpXUIUpogdyNbWrrWnqoULg7cdUS1OwfmRO24OvaVgZzizPNPOGIHrxpcJJpFiEGiylrIjlJ4dGYZ8KMiBfsX3B3CsMGc0RCMTCLBAH6phbD+qem9XiF2++d3dMJaze7olADRFPFFYKQnfjSNLhf5FG96VOjSWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133985; c=relaxed/simple;
	bh=DMhScoMzcATfd7YrXVTcpzy9toGu1J9btlk3raa7pg4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h63mYZJpWD6veNkleCR8pZRYc38FYPAxwIXsEhQaXqW7XrKd5/BrRDGMZvc4fL9iuEcn+cO4OPk0FcFZmcijdVyN1UEcBwpys+1S8udOL4zn73701qtIvy338p9YyFQtIOxepVZ7M5BYvm4+Jk80vfmZHV//HzVTFkOI2Nsx5vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ENN79feU; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ENN79feU"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a1273de95aso7195535e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 02:13:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773133981; cv=none;
        d=google.com; s=arc-20240605;
        b=AFZitQDHmj+ZTNoJRsws7beJrpBS5/BVK5yjAujABWc13gNaYF4DDU/0zOodo3Cwyc
         qnuJ9eyxY1sbm/yzTrlFKqQs//6BXHSJxyxk6bm+EEouwzXnV3ADT3GK42xR7SMrb9g2
         K4+v3RHeNan54gnWOMj2Y2x3yn8JRBXs400jdjtv64VMCPkXTn8ggowGk7p9q3Ga44kt
         ci/Nx+vpHfXwC5LV2I31M7E+EIDsUggGL92e/07i564m3Pq3/6VZDpgnO8pvNQGATpbz
         O4g77tZ61w9KAhKCmaN00yx+h2sU2Qs8KoHsR/uJ8ivzeSdQltslr/K/V20BwjtmAeVv
         gP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8F2bhMtMSjj2oDQi+clrIi22Hq+QZEwsyB8SqkUi+EM=;
        fh=pmz/Zq3MzNWwRoEBIAk+rnHMHCVZnhBxIpplwwjYvvQ=;
        b=hxgYlr4b0Bfti0JCg7XG2y9lOJ20XumKXiPYz0B1MfMycv25qA2+z3lGGvL0UaCT1E
         UG/vLYNeRJxw5hnVkmevWP2JeUhOJ7kZFPtzAGtUtovxlZ2HkblmHGkUYTVH6NhJCrEd
         0tgU84hEJkdYWLWKPjvbADh4WmXNxDoEtMBJFu96zLlM4HZ+n1QrIG7d1Sb0EohvQsCA
         6LPB2HrGOufh6VFnUbss9hPE7K7X1mEAaNSpp4O5SBdoj9+uqVVjS3w3FMxBFMTfoOxz
         yX0O3pJgFM3ln9DQroP5eSi8POHcFUCP0dx0D4VWdt4u1mfwQC11/SEHzlK1wAD3mnsC
         N6IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773133981; x=1773738781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8F2bhMtMSjj2oDQi+clrIi22Hq+QZEwsyB8SqkUi+EM=;
        b=ENN79feUFr/qrg8Pp7VwKbCYYP2ysXj4v3nI9ttqud+iUvAgc1Wk8CU7AaNuvrqbio
         4jCP9HRPatrJ6j+TyC3r+DfqYaJ4ckEI8J8CVf/HHlko8H6qFUXcygm72wH53++Bj5FY
         B3Mzs9ixurGFFEh9efLzvAUnyLWtfrMz8NvvYiXcMd3D6M2xR+haA9cUGUJuNeyv1W0Z
         VY3OnQEWbncNCRZ1gjK4pk6Nqn1a9KVkwKJhuzKEuwMPYFRcd32om0uu1SYK2K3lPZjK
         lJ4GN152jGanbxMuGiL56Me/AkFD9FdCo3Ad9Xg0Yp93EhiaQnlyul1tdvEV/b2wcT2B
         HshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773133981; x=1773738781;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8F2bhMtMSjj2oDQi+clrIi22Hq+QZEwsyB8SqkUi+EM=;
        b=gUu3Kz727bxSGC9t2bm2O9E2E3610R+W8l4tIh8mdIcu6BYIGbyiU8UZLGoX7sKPe0
         56s7BsKg8r7/CxWbiEzNtxa61kMUqI2LLt9uOPPjbdsxI/e6Q17mn5cRrwvl8SbC2CVO
         Hx+XateKXKRYJl1mm4zZLaK2tHGVmMjd/oeMQUSlt1H+2ZEEodpnwSP56e1zldKMfFit
         jeK/gN8J2R9gjF16xf8YFVOa39LjIHuO4VXHTsu/VIUH9V4iEKYW7USpMMkEmdOSx49C
         mj67OLHWu0sAcCNWGAt+CpbY/bWq/iwfeuzPfqXJhGBeKbX+UeOkwJU5i0kJnZ2EVnU9
         NhKw==
X-Forwarded-Encrypted: i=1; AJvYcCWaDddy4wFItKplDiTjjzyUUq+75yRq+MwysR8WYKETWqbZlVQRf0vgAFM6EGwkSR/lQX/E8EJ3VmWvXUSm@vger.kernel.org
X-Gm-Message-State: AOJu0YxFS4MntCEln9txqJFOKxmrn6zCRoJq001U6v80lygPqWic0d7C
	8IDAMUI+GgwLgv3ovxRvN1GCUkA1A9KHbikYtpkXWO23yK6yrxxHuQssP02mi0+3Ds6hhsqoUgY
	9mJw1eK4mx8z7caDkUpG6Ah2ypSXiOTwz9XUj91Io
X-Gm-Gg: ATEYQzy/KXhBzSRDPKyZlGEruAhOFSLejun/YXdiDPVsbs53GWw/lygqsLhv7e5lcvJ
	PyZl9Dcakj/kwvkhwtKkrRUYPYAu3bEuRD8uZpOgwDrE6juv1J7rQkgpNZSgz4QxE7kcI6Nc/LV
	c5gxucFKSgY8+9ApMlfy+i0KKP0+UrA/g+sf1wVmd+qOjREV8bw7gQpUL9IaambXkxTF6wuAS4Z
	WTqOYasbNNYFboER8KvptSZ8pxTRQXpFcrq+qw4hjXt01o8WBPL2+QvFm/GnH3mdgxW/aEVyUYk
	IVo764GRix37A18niY3WYf42WXcyP1gvh1s2CfAEuKMVMGJ0t07DWBh+5BYa3QINg1lYgQ==
X-Received: by 2002:a05:6512:15a0:b0:5a1:3d7f:8f99 with SMTP id
 2adb3069b0e04-5a13d7f92a6mr4647476e87.33.1773133980196; Tue, 10 Mar 2026
 02:13:00 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 02:12:56 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 02:12:55 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aa9uiQ_KBcX7X0My@google.com>
References: <20260309-gmem-st-blocks-v3-0-815f03d9653e@google.com>
 <20260309-gmem-st-blocks-v3-2-815f03d9653e@google.com> <aa9uiQ_KBcX7X0My@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 02:12:55 -0700
X-Gm-Features: AaiRm51A8Xbcuhtm9ZZHMK7hG6LdHLXwjTxvFIPiUIWCbO2N0i2NdJbEHgq4azA
Message-ID: <CAEvNRgH1RAV0rcaUx717JcHryB6=teXYoGtEzZwGwmy3MWwOcw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/4] KVM: guest_memfd: Set release always on
 guest_memfd mappings
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	rientjes@google.com, rick.p.edgecombe@intel.com, yan.y.zhao@intel.com, 
	fvdl@google.com, jthoughton@google.com, vannapurve@google.com, 
	shivankg@amd.com, michael.roth@amd.com, pratyush@kernel.org, 
	pasha.tatashin@soleen.com, kalyazin@amazon.com, tabba@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Lisa Wang <wyihan@google.com>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Mar 09, 2026, Ackerley Tng wrote:
>> Set release always on guest_memfd mappings to enable the use of
>> .invalidate_folio, which performs inode accounting for guest_memfd.
>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  virt/kvm/guest_memfd.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 77219551056a7..8246b9fbcf832 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -607,6 +607,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>  	mapping_set_inaccessible(inode->i_mapping);
>>  	/* Unmovable mappings are supposed to be marked unevictable as well. */
>>  	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>> +	mapping_set_release_always(inode->i_mapping);
>
> *sigh*
>
> So... an internal AI review bot flagged setting AS_RELEASE_ALWAYS as being
> potentially problematic, and I started poking around, mostly because I was
> curious.  I'm pretty sure the exact scenario painted by the bot isn't possible,
> but I do think a similar issue exists in at least truncate_error_folio().  Or at
> least, *should* exist, but doesn't because of a different bug.
>
> On memory error, kvm_gmem_error_folio() will get invoked via this code.  Note
> the "err != 0" check.  kvm_gmem_error_folio() returns MF_DELAYED, which has an
> arbitrary value of '2', and so KVM is always signalling "failure".
>
> 		int err = mapping->a_ops->error_remove_folio(mapping, folio);
>
> 		if (err != 0)
> 			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
> 		else if (!filemap_release_folio(folio, GFP_NOIO))
> 			pr_info("%#lx: failed to release buffers\n", pfn);
>
> I _think_ that's bad?  On x86, if I'm following the breadcrubs correctly, we'll
> end up in this code in kill_me_maybe()
>
> 	pr_err("Memory error not recovered");
> 	kill_me_now(cb);
>
> and send what I assume is a relatively useless SIGBUS and likely kill the VM.
>
> 	struct task_struct *p = container_of(ch, struct task_struct, mce_kill_me);
>
> 	p->mce_count = 0;
> 	force_sig(SIGBUS);
>

Glad you agree that's bad :). We reported this earlier and Lisa has been
working on a fix. RFC v1 is here [1].

RFC v2 (Lisa is about to post it) will address David's comments by
aligning shmem to also return MF_DELAYED like guest_memfd, then handling
MF_DELAYED returned from .error_remove_folio() accordingly so that it's
not interpreted as a memory failure handling failure.

[1] https://lore.kernel.org/all/cover.1760551864.git.wyihan@google.com/#r

> But even if that's somehow the "right" behavior, we're doing it purely by
> accident.
>
> As for this patch, if we fix that bug by returning 0, then filemap_release_folio()
> is definitely reachable by at least one flow, so I think guest_memfd also needs
> to implement release_folio()?
>

Is posix_fadvise() the one flow you're talking about?

It indeed calls filemap_release_folio() through mapping_try_invalidate()
-> mapping_evict_folio() -> filemap_release_folio().

From Documentation/filesystems/locking.rst:

  ->release_folio() is called when the MM wants to make a change to the
  folio that would invalidate the filesystem's private data.  For example,
  it may be about to be removed from the address_space or split.  The folio
  is locked and not under writeback.  It may be dirty.  The gfp parameter
  is not usually used for allocation, but rather to indicate what the
  filesystem may do to attempt to free the private data.  The filesystem may
  return false to indicate that the folio's private data cannot be freed.
  If it returns true, it should have already removed the private data from
  the folio.  If a filesystem does not provide a ->release_folio method,
  the pagecache will assume that private data is buffer_heads and call
  try_to_free_buffers().

I could implement .release_folio().

Returning false seems like the easier solution, and is kind of in line
with the documentation above. A guest_memfd folio does not have private
data, so without private data, the private data cannot be freed.

(Took me a while to notice that having private data is not the same
as having something in folio->private, so this doesn't change even after
the direct map removal series lands.)

Returning false is going to break shrink_folio_list(), but that probably
won't affect guest_memfd for now.

Returning false also breaks page_cache_pipe_buf_try_steal(). Does anyone
more familiar with splicing know if that could affect guest_memfd?

Returning true could also work, to indicate that the folio's private
data has been "removed". I'd also have to do inode_sub_bytes() in
.release_folio() then, since in mapping_evict_folio(), remove_mapping()
doesn't call .invalidate_folio().

Then we will have to separately ensure that in truncate_error_folio(),
guest_memfd doesn't double-deduct the folio's size from the inode. This
should be semantically correct though, since IIUC .invalidate_folio() is
when a folio is removed (clean or dirty), but .release_folio() is only
for clean folios. If .error_remove_folio() returns MF_DELAYED, the
truncation didn't happen and so there should be no call to
.release_folio().

>
>
> Full AI bot text:
> --
> Setting the AS_RELEASE_ALWAYS flag causes folio_needs_release() to return
> true. This correctly triggers .invalidate_folio during truncation, but does
> it also unintentionally expose guest_memfd folios to eviction via
> posix_fadvise(POSIX_FADV_DONTNEED)?
>
> If userspace calls posix_fadvise() on a guest_memfd file, the core mm
> calls mapping_evict_folio(). Because folio_needs_release() is true, it
> calls filemap_release_folio().
>
> Since guest_memfd does not implement a .release_folio address space
> operation, filemap_release_folio() falls back to calling
> try_to_free_buffers(). Could this fallback cause a warning?
>
> fs/buffer.c:try_to_free_buffers() {
> 	...
> 	/* Misconfigured folio check */
> 	if (WARN_ON_ONCE(!folio_buffers(folio)))
> 		return true;
> 	...
> }
>
> Because the guest_memfd folio has no private data, folio_buffers()
> is NULL, which will trigger this WARN_ON_ONCE.
>
> Furthermore, try_to_free_buffers() returns true, allowing the folio to be
> removed from the page cache. Because this eviction path bypasses
> truncate_cleanup_folio(), it never calls .invalidate_folio.
>
> Does this mean inode_sub_bytes() is skipped, leaking the inode block
> accounting?
>
> Userspace could potentially trigger the warning and infinitely inflate the
> inode's block count with:
>     struct kvm_create_guest_memfd args = { .size = 4096 };
>     int fd = ioctl(kvm_vm_fd, KVM_CREATE_GUEST_MEMFD, &args);
>     fallocate(fd, 0, 0, 4096);
>     posix_fadvise(fd, 0, 4096, POSIX_FADV_DONTNEED);
> Should guest_memfd implement a .release_folio callback that simply
> returns false to prevent these folios from being evicted?
> --
