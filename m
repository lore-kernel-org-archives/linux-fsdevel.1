Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E521F36F439
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=38.105.200.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839974; cv=fail; b=eEbBbKDzgk8ir/3CCw+nMqpLXMcFAKbC+Ju37eJ6TfA00xK2O/kOCUPTh7SVGdA9jOWJO82GT0nmyTRR2R/UkMhT21iUEveUrgCnNTbAHrdJuXHMXHpfdJwbjRCr9HYPYX1uBl/q+WpvY1FIbPuL1S7CkuASlppD/Hhui96sz70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839974; c=relaxed/simple;
	bh=vvC7LqN1fBP+Sdqqe6SaGZX3gSBJruo0z2XEJ84M2D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Bj/kWCGBwbfODlN6SapimHozop+m1S2MnRCsrXTrgznb8WS8Bsr8soGUK1GLivjrMxtiucm+EA9v0T//ni32fFT8+J5U0s/yGz9SgQLP8J891GbBw3Rvx7B9K7Uf9t+A1Kc4O/6nAuhc2KQHNCw9bJxTvLn+x4t8r10Lk2SNcyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=Tydb1zE5; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=COtkADUn; arc=fail smtp.client-ip=38.105.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="Tydb1zE5";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="COtkADUn"
Received: from mail-lf1-f72.google.com ([209.85.167.72])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.99.4)
 	id 1wec7Q-00000008Pp3-1eDG
 	for linux-fsdevel@vger.kernel.org;
 	Tue, 30 Jun 2026 13:19:32 -0400
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5aeb711dff7so959908e87.3
         for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782839971; cv=none;
         d=google.com; s=arc-20260327;
         b=ec/ZxNnZ64ePFbZmZLs3NLnmuyPwI/QGNqKQ/EShC++Hy48/C4Ss9jRkdmuLr3LuF+
          8wjxtqPAiaN4Riv665uKTWTYkd+5nUUpo4brTXuOA8giuKAh2S4p8niocSlpZLaziZzy
          QujsoGiORaar2AtvGiEIOjyx/qS6xGageQEun6cKvwyyfpMEyZ2xmyjXvbzEwO4O8Lgh
          7KYF7mGcmx+MaNkqb2TE5dngSqklWzLan6hrvsjY0byUW2DX030SWHCEBUsDeDiy4QAx
          tp3OELqXuNzdaqPypWueyzw2bBNP+SA7Fsa8EwOMGp0Y+qd+WLJUaONV7SdP6gQyoF6f
          DMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
         h=content-transfer-encoding:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:dkim-signature;
         bh=l3BDFr13lzvW17ABaI0/sIN4i/vOburrsEmcy0l5nOs=;
         fh=7lav7vOi1vzsVYpMS3MBUTjZQUfSDyGqY4Nof9FwVeI=;
         b=cr+e0G5GoKRBnJ/jx9Eq/6JFwvUoC/tZs8FquT8wYIaxLWaT42cfoz1ELprIxTAk+r
          LfmOS/Tj0W7hy+BWWn2kF/GONa9eric7pNfC9NyVe4mwQ7FVK3WUWhiMG6ZjiqZKcUMA
          TYrYlTEQq8xm2UnXmJ9Rk4W/WxRwlQbN5AnT0l8XLGrVqq+YYa/h8F2JySCQzhpU8mA9
          uL/dzWBeqmuaNJmA4QvkJTAIQnsyBqJMsTKkiRc/e2t03gZiE9/NR/xfiXLXAypEN8ui
          UyZSRkAdKYCSMMhlM2tAaKy6e54PNc8RucR+85yDWYY3Dy35Q/nxeG8zL/FpfXYRjJ2F
          4S3Q==;
         darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1782839971; x=1783444771; darn=vger.kernel.org;
         h=content-transfer-encoding:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:from:to:cc:subject:date
          :message-id:reply-to;
         bh=l3BDFr13lzvW17ABaI0/sIN4i/vOburrsEmcy0l5nOs=;
         b=Tydb1zE5I6brH9n8ugVQL2fCAeX33y5XSbUzG0wbQvaZaIte32wq1QKnHwOOWgefkF
          LwaiYbaO3aBtlWN0awZOkDivzNGNQG5cY8yJCXXT9qU7IaqjG/KY8HpzHgW8Z0BUB+fg
          7DoFuToCUqeiTFIJPcBrWWL4D+XsSv+gbm4ZA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1782839972;
  bh=l3BDFr13lzvW17ABaI0/sIN4i/vOburrsEmcy0l5nOs=;
  h=References:In-Reply-To:From:Date:Subject:To;
  b=COtkADUn1zxMonUYM/WWwbl9kMxb+xhWQUXhVEcAegni0oP5oFy5hgiQc31bQXFVi
  L2ovkMoVMBWnvIQVkdc0zNioGNxMbrTaiAQGS64pgi4sKRymsiAw+sXekG9wJhfqg1
  OWQg7qNGCUVP1J/Fqwjq04qUFZDeBQoL3iyS1iAr0yiEZtiakzkntOVpBGuljMifpO
  28QKrTNfvu0icfWTcR2sv2POzRPRr0LMYMX2XMi0uRoPzcZNUF72Vdf/UtiprGXmgX
  hNYWihgoRUketm3rtqNHashDx9VwFjZAQNN4fqqRNhR6S+qUWGp4M4hOVGJjn4LdxV
  5WfrU7JiTLqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20251104; t=1782839971; x=1783444771;
         h=content-transfer-encoding:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
          :to:cc:subject:date:message-id:reply-to;
         bh=l3BDFr13lzvW17ABaI0/sIN4i/vOburrsEmcy0l5nOs=;
         b=cyT7kNbOHgCRfn0YZecvMIrMptBYbop/vPd1GWboUvKvHkS2Ouw3lOqWJt71rRwS4g
          ofzN81Prh010h5CF5QAbfJ2H6FcGAva/06U3apJmvdiwKxoat7Bqf33VCZ8X4r3+lN9Y
          /eLCQpiuzmaQWuj4rpVerGtuba/JVx4zgtrQ0B4dkddO79H12ynDA/6Q9hK7FEyHZEeP
          /0Er+FA03RdYmV45t616p9KEMZsHFlomVQ2kZisMK1/fZVPsvSk7TFt9XJct7oK0Z6JO
          vPug5jJVjkKdYG3SXIiLJFWXQ6SympezxKiwkqgS+KdjIR8MhrojdVryVW+fIYO/g1Gs
          JzPw==
X-Forwarded-Encrypted: i=1; AHgh+Rofvoh2Ic/p9J+OnxgrF4yYENFmsqYl4nEM0Fm8O0+DyaUJqpW8ySgRwz/9YZh8ZdpVfyFPjSRUXTpN3mZG@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYCZCOlGC3FhKANyEP2oMZ7d8XwNdWTdI9j8OiXPiaGRagrLq
 	omeRysZ34UuHRY3SN09VL0UvmceM3pwERn8BvZfcVLjWN1Tr2iM+oZfJZ9esVopIjsAZfhp4+ho
 	WLcaKWtp6chxeX1xRw9Wy2dBjq540L3I8KB3lukFBKyAfTkTDMvUmYfAwZdstVXNyFKH0yyW2ng
 	wL3j+aQVhGNxWUKlbHueWVFsBIYfa+PxO3UvuniFAx
X-Gm-Gg: AfdE7cmnuxKqqq0l95MnsIpmi2vuDk1IrNMPwW44ix6ReXuqZYbxAImDuD+EZ6hpnu/
 	0n36xaYuwYVXjEFbh+BA0AYRt/WZihm0tm4mXOWxwOW9Lm17tEAvqe/X2hTf4ikePEeeS937Np3
 	BsDdTSmmYCZHsve9gcZK3r6XFz3DDpaHBIFcJmyH1Ou2VFRTYT+yjJuPHzRbK/BtF0zhA=
X-Received: by 2002:a05:6512:3f11:b0:5ae:b8c8:f2fa with SMTP id 2adb3069b0e04-5aebdbdef7emr1141211e87.50.1782839970989;
         Tue, 30 Jun 2026 10:19:30 -0700 (PDT)
X-Received: by 2002:a05:6512:3f11:b0:5ae:b8c8:f2fa with SMTP id
  2adb3069b0e04-5aebdbdef7emr1141194e87.50.1782839970509; Tue, 30 Jun 2026
  10:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com>
In-Reply-To: <CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com>
From: Gregg Leventhal <gleventhal@janestreet.com>
Date: Tue, 30 Jun 2026 13:18:52 -0400
X-Gm-Features: AVVi8CfkmjNR5nURtk2mdnYIAyOLZkKQSNyy9kqgwVeZ-P7zxW9roFxBxwv7kcc
Message-ID: <CAFN_u7FLMQ1JYCzD8+RDhSH6X4W6yHnp8GcidjEm1rvNMmZK2A@mail.gmail.com>
Subject: Re: Subject: [BUG/RFC] write-open file THP cache purge can discard
  dirty page cache
To: "To: Alexander Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
 	"Cc: Jan Kara" <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
 	Andrew Morton <akpm@linux-foundation.org>, Song Liu <song@kernel.org>, 
 	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 	linux-kernel@vger.kernel.org, Eric Hagberg <ehagberg@janestreet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Also, just to be explicit and prevent some potentially-wasted time:
This does not repro on XFS!   You need to point the reproducer at
Btrfs or Ext4 (or some other susceptible file system, but those are
the only ones Eric and I have confirmed, personally).


On Tue, Jun 30, 2026 at 1:01=E2=80=AFPM Gregg Leventhal
<gleventhal@janestreet.com> wrote:
>
> Hello,
>
> We (Gregg Leventhal <gleventhal@janestreet.com> and Eric Hagberg
>
> <ehagberg@janestreet.com>) have a reproducible data-loss issue involving =
file
>
> THPs and write-open, impacting filesystems that do not support
> writable large folios.
>
>
> Attached are:
>
>
>   - thp_write_open_cancel_dirty_repro.c
>
>   - thp-open-writeback-before-purge.patch
>
>
>
> Summary
>
> =3D=3D=3D=3D=3D=3D=3D
>
>
> On an affected 6.12 kernel with CONFIG_READ_ONLY_THP_FOR_FS=3Dy, a file c=
an
>
> contain read-only file THPs installed by khugepaged / MADV_COLLAPSE. When=
 that
>
> same file is later opened for write, do_dentry_open() notices
>
> filemap_nr_thps() and drops the page cache:
>
>
>         /*
>
>          * XXX: Huge page cache doesn't support writing yet. Drop all pag=
e
>
>          * cache for this file before processing writes.
>
>          */
>
>         if (f->f_mode & FMODE_WRITE) {
>
>                 if (filemap_nr_thps(inode->i_mapping)) {
>
>                         struct address_space *mapping =3D inode->i_mappin=
g;
>
>
>                         filemap_invalidate_lock(inode->i_mapping);
>
>                         unmap_mapping_range(mapping, 0, 0, 0);
>
>                         truncate_inode_pages(mapping, 0);
>
>                         filemap_invalidate_unlock(inode->i_mapping);
>
>                 }
>
>         }
>
>
> This is unsafe if the mapping also contains dirty folios.
>
> truncate_inode_pages() is not just a clean cache-dropping primitive. It c=
an
>
> call truncate_cleanup_folio(), which calls folio_cancel_dirty().
>
>
> In the attached reproducer, dirty appended data is discarded and later re=
ad(2)s
>
> return zeros.
>
>
> We observed this on btrfs and ext4, though most of the testing involved b=
trfs.
>
>
> The same issue should apply to any filesystem where file THPs can be crea=
ted
>
> by READ_ONLY_THP_FOR_FS but writable large folios are not supported. The
>
> do_dentry_open() block above is also unchanged in current mainline, so th=
is
>
> does not appear to be strictly 6.12-specific.
>
>
>
> Instrumentation
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Tracing the failure shows the dirty folios being invalidated from the
>
> write-open path. INVALIDATE_DIRTY and CANCEL_DIRTY below are labels from =
our
>
> own probes:
>
>
>         do_dentry_open / vfs_open
>
>           truncate_inode_pages_range
>
>             truncate_cleanup_folio
>
>               btrfs_invalidate_folio
>
>               folio_cancel_dirty
>
>
> A representative stack from the failing path:
>
>
>         INVALIDATE_DIRTY ...
>
>           btrfs_invalidate_folio
>
>           truncate_cleanup_folio
>
>           truncate_inode_pages_range
>
>           vfs_open
>
>
>         CANCEL_DIRTY ...
>
>           truncate_cleanup_folio
>
>           truncate_inode_pages_range
>
>           vfs_open
>
>
> This confirms that the appended dirty page-cache contents are being disca=
rded
>
> by the open-time THP cache purge rather than written back.
>
>
>
> Why this happens
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> The do_dentry_open() code is trying to handle the fact that some filesyst=
ems
>
> do not support writing to file THPs. The problematic assumption is that
>
> dropping the page cache is a safe cache-management operation.
>
>
> It is not safe when dirty folios are present, because truncate_inode_page=
s()
>
> cancels their dirty state without writeback.
>
>
> Note that the read-only file THPs themselves are clean. The data that is =
lost
>
> is unrelated dirty folios elsewhere in the same mapping, here the appende=
d
>
> tail, which get caught in the blanket truncate_inode_pages(mapping, 0) of=
 the
>
> entire mapping.
>
>
>
> Suggested fix direction
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Before dropping THP-bearing page cache on write-open, write back and wait=
 for
>
> any dirty folios. After writeback completes, the folios are clean, so the
>
> subsequent truncate_inode_pages() has no dirty state to cancel and the da=
ta is
>
> safe on disk. A later read() simply repopulates the cache from disk. If
>
> writeback fails, fail the open rather than silently discarding the data.
>
>
> The attached patch does this by adding filemap_write_and_wait(mapping) be=
fore
>
> the unmap_mapping_range() / truncate_inode_pages() sequence.
>
>
> Two caveats we are aware of with this approach:
>
>
>   - filemap_write_and_wait() flushes the entire mapping, so any write-ope=
n of
>
>     a file with filemap_nr_thps() > 0 now forces synchronous writeback. T=
his
>
>     path already did a full unmap + truncate, so the extra cost is probab=
ly
>
>     acceptable, but it is a behavior change.
>
>
>   - The writeback happens before unmap_mapping_range(). That is sufficien=
t for
>
>     the reproducer, where the dirty data comes from buffered write(2), so=
 the
>
>     folios are already marked dirty. We would appreciate guidance on whet=
her
>
>     unmap should precede the writeback in order to also cover data dirtie=
d
>
>     only via a writable shared mapping.
>
>
> An alternative would be to replace truncate_inode_pages() with a
>
> clean-page-only invalidation primitive, but then dirty file THPs / dirty =
pages
>
> may remain in the mapping and need careful handling.
>
>
>
> Mitigation
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> As a temporary mitigation, setting khugepaged's scan interval very high
>
> appears to prevent the issue by effectively stopping background file THP
>
> collapse:
>
>
>         echo 4294967295 >
> /sys/kernel/mm/transparent_hugepage/khugepaged/scan_sleep_millisecs
>
>
> This is not a complete fix. It reduces or disables khugepaged background
>
> collapse, including file THP collapse, and may reduce THP-related perform=
ance
>
> benefits for workloads that rely on khugepaged promotion. Fault-time anon=
ymous
>
> THP allocation is not disabled by this knob.
>
>
> Disabling CONFIG_READ_ONLY_THP_FOR_FS also seems to mitigate, but both ar=
e
>
> suboptimal, performance-impacting trade-offs.
>
>
>
> Reproducer
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> The attached reproducer does the following:
>
>
>   1. Creates a regular file with non-zero data.
>
>   2. Maps part of the file read-only and uses MADV_COLLAPSE to force a fi=
le
>
>      THP.
>
>   3. Opens the file for writing and appends non-zero data, leaving it dir=
ty in
>
>      page cache.
>
>   4. Closes the write fd.
>
>   5. Re-collapses a read-only file range so filemap_nr_thps(mapping) is
>
>      non-zero.
>
>   6. Opens the file for write again, triggering the do_dentry_open() THP =
purge.
>
>   7. Reads back the appended data.
>
>
> Whether any single iteration reproduces is a race against background
>
> writeback, so let the full iteration count run. A single clean pass does =
not
>
> by itself prove the kernel is unaffected.
>
>
> On an affected 6.12 host:
>
>
>         # ./thp_write_open_cancel_dirty_repro Maybe_corrupted_file
>
>         path=3DMaybe_corrupted_file base_size=3D67108864 append_size=3D16=
384 iters=3D200
>
>         REPRODUCED iter=3D0 bad_bytes=3D16384 first_bad=3D0 zero_count=3D=
16384
> append_off=3D67108864
>
>         first 64 got:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ..=
.
>
>         first 64 want: 5c df 63 e6 6a ed 71 f4 78 fb 7f 03 86 0a 8d 11 ..=
.
>
>
> The corrupted range is visible as a run of null bytes at the append offse=
t:
>
>
>         # rg --text '\x00{64}\x00*' $PWD --only-matching \
>
>               --byte-offset --no-line-number \
>
>             | awk -F: '{print $1, $2, length($3)}' | head -n1
>
>         /root/Maybe_corrupted_file 67108864 16384
>
>
>
> We are happy to test any preferred fix direction and can provide
> additional traces, as-needed.
>
>
> Thanks,
>
> Gregg Leventhal
>
> Eric Hagberg
