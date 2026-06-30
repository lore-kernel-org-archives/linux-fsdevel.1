Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A33DB318
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=38.105.200.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839305; cv=fail; b=cNOGhwIMJOFs68n3JgiD5tR/zFnofym5CBMMzB6LcDObU7AdE4bPANX05C2YEAM0DpUh7m0tHn30vs9gIsnnY8/Qlwnh72hREa3bY1Ra31vMMS43tlX+y/9X9l2p9DdnTt0rfqlCVS+q1DKXWluV9nrtwejmEXXxbmp9ugADpag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839305; c=relaxed/simple;
	bh=dKymk6ti78l0eMnafg7ottgM01INVwoa0SGn1C4IWZc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cJLMWKoL5xWZHVWnBIYweD0M6dHNOFjyX1cuJcHzJAiAR4g47uD5m/lhqj1S0tz70XSlfWi2Pt4yCOuwDnOECwwzFDuFqszjfPMmFXPGduoUS/73O1v37XVEuAwvzp7hLvCow6nTuB2XD+mX1knurEkTX4pGtefmeMD64KEY9A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=T2bhxXFB; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=2oUzoRBz; arc=fail smtp.client-ip=38.105.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="T2bhxXFB";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="2oUzoRBz"
Received: from mail-lf1-f69.google.com ([209.85.167.69])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.99.4)
 	id 1webqx-00000008Nwi-2J7n
 	for linux-fsdevel@vger.kernel.org;
 	Tue, 30 Jun 2026 13:02:31 -0400
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5aeba7dc09cso1370901e87.1
         for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782838950; cv=none;
         d=google.com; s=arc-20260327;
         b=HAZNCyNs2PKqHAyfZKebJQYWq70/c+qeJpIQXDZjJGcxE8PiZ2IZm1E6dAeM8043nW
          chhRkeWhUlMYOprATIUQrfFKKnr1YScy6Y5EdXNkcI4VA+r7zSCDFBMMN5X95nPq/UGq
          +jM1+xg7q2o8nCMd/Ffp1ma9vx+QNOBx/3xBDSUsdRQt2FdsBFRcCy8oW4X4A8eY5M77
          Uup73S8h2Df6zFHToQ2+CEkXryLgCu3DvwICtVl9psYmhJgHHBn7YuLBKEsInJPO6vt+
          kUCDc60OnitzP1FyC0P5eFD6S9/LNeCGdj4wxfwFoY613sgi6eIcTuq0rDpiEHagvUT9
          Uviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
         h=to:subject:message-id:date:from:mime-version:dkim-signature;
         bh=g86BNR22QJyRk8A6HyMntZCPCmMg+CFc+R/lhjPdGWM=;
         fh=VAA9eYAzIBY1UmO3oyOHbHGzUpiM7bMHmhJoookxevQ=;
         b=HNcZxUIO3QJJJDzy5pQNxYIy/dJf1QD5TJ0YALOZkxBf1RVxiq9gZ6Un1d99n2P0Ci
          MSiX57t1JOeOYD6BCmNG3df85wPb2sveSO7LgU5t2VAt53x3HUOVDZE1SZF52y3gEzLq
          dz8+5wjDO7Ky1Rzu2wgEqKA8mZVgF1U9XuWRdg6Gm02awdWRY9Yl9CcyxKOjYXnaYEpM
          3oXwn716N5swloWQ8J+sFg96a20E2o6mwmleMl0KlVK/yA6pYxMgJuymTKGdLude5guG
          70teumtxKk3eG+hUG5ZLoxdJO4bvQMON6sUkpA45NL2uwtd99jlNytKNTXp0N8JgUzwz
          H11w==;
         darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1782838950; x=1783443750; darn=vger.kernel.org;
         h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
          :date:message-id:reply-to;
         bh=g86BNR22QJyRk8A6HyMntZCPCmMg+CFc+R/lhjPdGWM=;
         b=T2bhxXFBmknK8Ts5vFat2/OEe3GOhkbYjr1kz8iUU7EJrGpW/rAl2avEyroL3THNVD
          fzHJOlEMjJrGAOpVsZ7ubf1gAeNFEDIDw06phy8sBxEV+7IXppJxIVC+BW6YU0x1bawg
          pkhJEADmz9w8ErOGTLwQ7GIhU8PwOoggP0DQI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1782838951;
  bh=g86BNR22QJyRk8A6HyMntZCPCmMg+CFc+R/lhjPdGWM=;
  h=From:Date:Subject:To;
  b=2oUzoRBz8MyARpUOm+JHyz+ndzJmtJ4x9svR8a4ellqbkeFyvyuWiB65SkKWG7DVn
  SFJyutRLciJDbu3cs/LZoAnUzhWCfZbY2PKPEYAvV9C+KHYxPjFDpgThBpY4T31Sba
  CM5yq1by6ybVvv5a95m20K7SiI6gAcEmU47A5JFIvJUFEO+4V/spYQEGsJgyAz4Qrf
  y8cSg9v5I3QeGUfy2FVTs9eCw1n1A20JLwKpa9qcD1/KCSuFGUxMo5mePnfL5Bk8Rg
  JkndFpPXhTCs190f6wKJZn6BkH+alCNyl2QWb1zuTvWnLW8pZyY9sug7WTZAHj4DUq
  kl0ljyzmlw9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20251104; t=1782838950; x=1783443750;
         h=to:subject:message-id:date:from:mime-version:x-gm-gg
          :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
         bh=g86BNR22QJyRk8A6HyMntZCPCmMg+CFc+R/lhjPdGWM=;
         b=l8PCSs7idFpRC7+fu+UbTsg5JkM7Oi/BTeCLL3M5tuj1/ZbTHi7jSaChE8wDn4V+F5
          DcRuJVhWZS7e/tu6dw7Xa88W3/bEm1DEIkKx0O6jQ6yCECw6nUb5O6uK9wcD1fVEQYsS
          ZxodfupUHMU9HceipU/BAzjTzQreR/zemm4qTxTQ8U5q7/tR1uqa1Pm0wJ00jZO5O5Ty
          628+NCqJ1OgnjqKRcP8xOhEZ3W/PAQlNRo8YajzBju7jOoTYqcXWuBukuwKJ6e1XnCMM
          h3Er0B3Bg+9zbxm9RcDAm7HtEOtKgd4hBS3iWeoycZIZy8OdBpSJh8g6Z5I/YygfB4pr
          1etA==
X-Forwarded-Encrypted: i=1; AHgh+RocCWuIsL5s8GSjO015AtdeuzVWY7BSODIF0Kd+A63bOgalhtl6RUXAJQrHVIC1XOJH7C+j5ylUgfc0e6M/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0AkOID6h9/H4SvnlF4/gCfvKca1izUWd/jyUHX31PO4D5Alw1
 	uURnQyeBtQXLfKBsn2H4qdW28/a6umjj8wCTkSIcWZZxIrpzmgeE/5/kkxILPj3wXEt3Lw/1xK6
 	3spTm3aY+6+5UWTbgzU0W/L2zTvvfAvFqQCxfaHs6zlq8GcA4aeYbCL5ot59ZDmgLfuVX7QTeGw
 	BSFD0enRCEjez1eLdaRBPnHhCBuiH8WDn0P7ZLiRJ8
X-Gm-Gg: AfdE7cnb89+zsblovE07SlSiQQd4LDPQRMwUzHtH0EEV+wC+UioaBMqqvP+xQJWtico
 	Wx9b4Z2hiSPYPDfC6ZdJltzLgtIfX8wZ7CO6eOwT1VNNJNIlf/7GRQFDECatjlbOc/9SBBXqvoj
 	qxYOQMCxk0Q8iJzu4tPCWQH9FCpjKhozTgN6GlBopUiu1HhejWVouSSfxc7CimTDsCY8I=
X-Received: by 2002:a05:6512:65dc:10b0:5ae:a9ed:2497 with SMTP id 2adb3069b0e04-5aebdbee80fmr829734e87.56.1782838950054;
         Tue, 30 Jun 2026 10:02:30 -0700 (PDT)
X-Received: by 2002:a05:6512:65dc:10b0:5ae:a9ed:2497 with SMTP id
  2adb3069b0e04-5aebdbee80fmr829725e87.56.1782838949566; Tue, 30 Jun 2026
  10:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gregg Leventhal <gleventhal@janestreet.com>
Date: Tue, 30 Jun 2026 13:01:53 -0400
X-Gm-Features: AVVi8CekOPYYl5IHgzLycKZLehIvmY59M11mmzg6RiFkzD521pnKtRDjoGhFjSw
Message-ID: <CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com>
Subject: Subject: [BUG/RFC] write-open file THP cache purge can discard dirty
  page cache
To: "To: Alexander Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
 	"Cc: Jan Kara" <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
 	Andrew Morton <akpm@linux-foundation.org>, Song Liu <song@kernel.org>, 
 	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 	linux-kernel@vger.kernel.org, Eric Hagberg <ehagberg@janestreet.com>
Content-Type: multipart/mixed; boundary="0000000000004808e406557b8afa"

--0000000000004808e406557b8afa
Content-Type: text/plain; charset="UTF-8"

Hello,

We (Gregg Leventhal <gleventhal@janestreet.com> and Eric Hagberg

<ehagberg@janestreet.com>) have a reproducible data-loss issue involving file

THPs and write-open, impacting filesystems that do not support
writable large folios.


Attached are:


  - thp_write_open_cancel_dirty_repro.c

  - thp-open-writeback-before-purge.patch



Summary

=======


On an affected 6.12 kernel with CONFIG_READ_ONLY_THP_FOR_FS=y, a file can

contain read-only file THPs installed by khugepaged / MADV_COLLAPSE. When that

same file is later opened for write, do_dentry_open() notices

filemap_nr_thps() and drops the page cache:


        /*

         * XXX: Huge page cache doesn't support writing yet. Drop all page

         * cache for this file before processing writes.

         */

        if (f->f_mode & FMODE_WRITE) {

                if (filemap_nr_thps(inode->i_mapping)) {

                        struct address_space *mapping = inode->i_mapping;


                        filemap_invalidate_lock(inode->i_mapping);

                        unmap_mapping_range(mapping, 0, 0, 0);

                        truncate_inode_pages(mapping, 0);

                        filemap_invalidate_unlock(inode->i_mapping);

                }

        }


This is unsafe if the mapping also contains dirty folios.

truncate_inode_pages() is not just a clean cache-dropping primitive. It can

call truncate_cleanup_folio(), which calls folio_cancel_dirty().


In the attached reproducer, dirty appended data is discarded and later read(2)s

return zeros.


We observed this on btrfs and ext4, though most of the testing involved btrfs.


The same issue should apply to any filesystem where file THPs can be created

by READ_ONLY_THP_FOR_FS but writable large folios are not supported. The

do_dentry_open() block above is also unchanged in current mainline, so this

does not appear to be strictly 6.12-specific.



Instrumentation

===============


Tracing the failure shows the dirty folios being invalidated from the

write-open path. INVALIDATE_DIRTY and CANCEL_DIRTY below are labels from our

own probes:


        do_dentry_open / vfs_open

          truncate_inode_pages_range

            truncate_cleanup_folio

              btrfs_invalidate_folio

              folio_cancel_dirty


A representative stack from the failing path:


        INVALIDATE_DIRTY ...

          btrfs_invalidate_folio

          truncate_cleanup_folio

          truncate_inode_pages_range

          vfs_open


        CANCEL_DIRTY ...

          truncate_cleanup_folio

          truncate_inode_pages_range

          vfs_open


This confirms that the appended dirty page-cache contents are being discarded

by the open-time THP cache purge rather than written back.



Why this happens

================


The do_dentry_open() code is trying to handle the fact that some filesystems

do not support writing to file THPs. The problematic assumption is that

dropping the page cache is a safe cache-management operation.


It is not safe when dirty folios are present, because truncate_inode_pages()

cancels their dirty state without writeback.


Note that the read-only file THPs themselves are clean. The data that is lost

is unrelated dirty folios elsewhere in the same mapping, here the appended

tail, which get caught in the blanket truncate_inode_pages(mapping, 0) of the

entire mapping.



Suggested fix direction

=======================


Before dropping THP-bearing page cache on write-open, write back and wait for

any dirty folios. After writeback completes, the folios are clean, so the

subsequent truncate_inode_pages() has no dirty state to cancel and the data is

safe on disk. A later read() simply repopulates the cache from disk. If

writeback fails, fail the open rather than silently discarding the data.


The attached patch does this by adding filemap_write_and_wait(mapping) before

the unmap_mapping_range() / truncate_inode_pages() sequence.


Two caveats we are aware of with this approach:


  - filemap_write_and_wait() flushes the entire mapping, so any write-open of

    a file with filemap_nr_thps() > 0 now forces synchronous writeback. This

    path already did a full unmap + truncate, so the extra cost is probably

    acceptable, but it is a behavior change.


  - The writeback happens before unmap_mapping_range(). That is sufficient for

    the reproducer, where the dirty data comes from buffered write(2), so the

    folios are already marked dirty. We would appreciate guidance on whether

    unmap should precede the writeback in order to also cover data dirtied

    only via a writable shared mapping.


An alternative would be to replace truncate_inode_pages() with a

clean-page-only invalidation primitive, but then dirty file THPs / dirty pages

may remain in the mapping and need careful handling.



Mitigation

==========


As a temporary mitigation, setting khugepaged's scan interval very high

appears to prevent the issue by effectively stopping background file THP

collapse:


        echo 4294967295 >
/sys/kernel/mm/transparent_hugepage/khugepaged/scan_sleep_millisecs


This is not a complete fix. It reduces or disables khugepaged background

collapse, including file THP collapse, and may reduce THP-related performance

benefits for workloads that rely on khugepaged promotion. Fault-time anonymous

THP allocation is not disabled by this knob.


Disabling CONFIG_READ_ONLY_THP_FOR_FS also seems to mitigate, but both are

suboptimal, performance-impacting trade-offs.



Reproducer

==========


The attached reproducer does the following:


  1. Creates a regular file with non-zero data.

  2. Maps part of the file read-only and uses MADV_COLLAPSE to force a file

     THP.

  3. Opens the file for writing and appends non-zero data, leaving it dirty in

     page cache.

  4. Closes the write fd.

  5. Re-collapses a read-only file range so filemap_nr_thps(mapping) is

     non-zero.

  6. Opens the file for write again, triggering the do_dentry_open() THP purge.

  7. Reads back the appended data.


Whether any single iteration reproduces is a race against background

writeback, so let the full iteration count run. A single clean pass does not

by itself prove the kernel is unaffected.


On an affected 6.12 host:


        # ./thp_write_open_cancel_dirty_repro Maybe_corrupted_file

        path=Maybe_corrupted_file base_size=67108864 append_size=16384 iters=200

        REPRODUCED iter=0 bad_bytes=16384 first_bad=0 zero_count=16384
append_off=67108864

        first 64 got:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ...

        first 64 want: 5c df 63 e6 6a ed 71 f4 78 fb 7f 03 86 0a 8d 11 ...


The corrupted range is visible as a run of null bytes at the append offset:


        # rg --text '\x00{64}\x00*' $PWD --only-matching \

              --byte-offset --no-line-number \

            | awk -F: '{print $1, $2, length($3)}' | head -n1

        /root/Maybe_corrupted_file 67108864 16384



We are happy to test any preferred fix direction and can provide
additional traces, as-needed.


Thanks,

Gregg Leventhal

Eric Hagberg

--0000000000004808e406557b8afa
Content-Type: text/x-c-code; charset="US-ASCII"; name="thp_write_open_cancel_dirty_repro.c"
Content-Disposition: attachment; 
	filename="thp_write_open_cancel_dirty_repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mr0w2z8f1>
X-Attachment-Id: f_mr0w2z8f1

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKLyoKICogUmVwcm9kdWNlciBmb3Ig
d3JpdGUtb3BlbiBmaWxlLVRIUCBwYWdlLWNhY2hlIHB1cmdlIGRpc2NhcmRpbmcgZGlydHkgZGF0
YS4KICoKICogSW50ZW5kZWQgZm9yIExpbnV4IGtlcm5lbHMgd2l0aCBDT05GSUdfUkVBRF9PTkxZ
X1RIUF9GT1JfRlM9eSBhbmQgYSBmaWxlc3lzdGVtCiAqIHRoYXQgZG9lcyBub3Qgb3B0IGludG8g
d3JpdGFibGUgbGFyZ2UgZm9saW9zIChlLmcuIGJ0cmZzL2V4dDQgb24gYWZmZWN0ZWQKICoga2Vy
bmVscykuICBSdW4gb24gc3VjaCBhIGZpbGVzeXN0ZW0sIHdpdGggVEhQIGVuYWJsZWQuCiAqCiAq
IE1lY2hhbmlzbToKICogICAxLiBDcmVhdGUgYSBmaWxlIGFuZCBmYXVsdC9jb2xsYXBzZSBhIHJl
YWQtb25seSBmaWxlIFRIUC4KICogICAyLiBPcGVuIGZvciB3cml0ZSBhbmQgYXBwZW5kIG5vbi16
ZXJvIGJ5dGVzLCBsZWF2aW5nIHRoZW0gZGlydHkgaW4gY2FjaGUuCiAqICAgICAgVGhlIGZpcnN0
IHdyaXRlLW9wZW4gbWF5IHB1cmdlIHRoZSBlYXJsaWVyIFRIUDsgdGhhdCdzIGZpbmUuCiAqICAg
My4gQ2xvc2UgdGhlIHdyaXRlIGZkLCB0aGVuIGNvbGxhcHNlIGEgY2xlYW4gcmVhZC1vbmx5IHJh
bmdlIGFnYWluIHNvIHRoZQogKiAgICAgIG1hcHBpbmcgaGFzIGZpbGUgVEhQcyB3aGlsZSB0aGUg
YXBwZW5kZWQgZm9saW9zIGFyZSBzdGlsbCBkaXJ0eS4KICogICA0LiBPcGVuIGZvciB3cml0ZSBh
Z2Fpbi4gIEFmZmVjdGVkIGtlcm5lbHMgY2FsbCB0cnVuY2F0ZV9pbm9kZV9wYWdlcygpCiAqICAg
ICAgZnJvbSBkb19kZW50cnlfb3BlbigpIHRvIGRyb3AgdGhlIFRIUC1iZWFyaW5nIGNhY2hlLiAg
VGhhdCBjYW4gY2FsbAogKiAgICAgIGZvbGlvX2NhbmNlbF9kaXJ0eSgpIG9uIHRoZSBkaXJ0eSBh
cHBlbmRlZCBmb2xpb3MuCiAqICAgNS4gUmVhZCBiYWNrIGFwcGVuZGVkIGJ5dGVzLiAgT24gZmFp
bHVyZSB0aGV5IGFyZSB6ZXJvL2luY29ycmVjdC4KICoKICogVGhpcyBpbnRlbnRpb25hbGx5IHVz
ZXMgTUFEVl9DT0xMQVBTRSBmb3IgZGV0ZXJtaW5pc20gaW5zdGVhZCBvZiB3YWl0aW5nIGZvcgog
KiBiYWNrZ3JvdW5kIGtodWdlcGFnZWQuICBJZiBNQURWX0NPTExBUFNFIHJldHVybnMgRUlOVkFM
LCBjaGVjayB0aGF0IG5vIGZkIGlzCiAqIG9wZW4gZm9yIHdyaXRlIGFuZCB0aGF0IFJFQURfT05M
WV9USFBfRk9SX0ZTIC8gVEhQIGFyZSBlbmFibGVkLgogKi8KI2RlZmluZSBfR05VX1NPVVJDRQoj
aW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxpbnR0eXBlcy5o
PgojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRp
by5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5
cy9tbWFuLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiNp
bmNsdWRlIDx1bmlzdGQuaD4KCiNpZm5kZWYgTUFEVl9DT0xMQVBTRQojZGVmaW5lIE1BRFZfQ09M
TEFQU0UgMjUKI2VuZGlmCiNpZm5kZWYgTUFQX0ZJWEVEX05PUkVQTEFDRQojZGVmaW5lIE1BUF9G
SVhFRF9OT1JFUExBQ0UgMHgxMDAwMDAKI2VuZGlmCgojZGVmaW5lIEtpQiAxMDI0VUxMCiNkZWZp
bmUgTWlCICgxMDI0VUxMICogS2lCKQojZGVmaW5lIEhQQUdFICgyVUxMICogTWlCKQoKc3RhdGlj
IHZvaWQgZGllKGNvbnN0IGNoYXIgKndoYXQpCnsKICBmcHJpbnRmKHN0ZGVyciwgIiVzOiAlc1xu
Iiwgd2hhdCwgc3RyZXJyb3IoZXJybm8pKTsKICBleGl0KDIpOwp9CgpzdGF0aWMgdm9pZCB4d3Jp
dGVfZnVsbChpbnQgZmQsIGNvbnN0IHZvaWQgKmJ1Ziwgc2l6ZV90IGxlbiwgb2ZmX3Qgb2ZmKQp7
CiAgY29uc3QgY2hhciAqcCA9IGJ1ZjsKICB3aGlsZSAobGVuID4gMCkgewogICAgc3NpemVfdCBu
ID0gcHdyaXRlKGZkLCBwLCBsZW4sIG9mZik7CiAgICBpZiAobiA8IDApIGRpZSgicHdyaXRlIik7
CiAgICBpZiAobiA9PSAwKSB7CiAgICAgIGZwcmludGYoc3RkZXJyLCAic2hvcnQgcHdyaXRlOiAw
XG4iKTsKICAgICAgZXhpdCgyKTsKICAgIH0KICAgIHAgKz0gbjsKICAgIG9mZiArPSBuOwogICAg
bGVuIC09IChzaXplX3QpbjsKICB9Cn0KCnN0YXRpYyB2b2lkIHhyZWFkX2Z1bGwoaW50IGZkLCB2
b2lkICpidWYsIHNpemVfdCBsZW4sIG9mZl90IG9mZikKewogIGNoYXIgKnAgPSBidWY7CiAgd2hp
bGUgKGxlbiA+IDApIHsKICAgIHNzaXplX3QgbiA9IHByZWFkKGZkLCBwLCBsZW4sIG9mZik7CiAg
ICBpZiAobiA8IDApIGRpZSgicHJlYWQiKTsKICAgIGlmIChuID09IDApIHsKICAgICAgZnByaW50
ZihzdGRlcnIsICJzaG9ydCBwcmVhZCBhdCBvZmY9JWpkXG4iLCAoaW50bWF4X3Qpb2ZmKTsKICAg
ICAgZXhpdCgyKTsKICAgIH0KICAgIHAgKz0gbjsKICAgIG9mZiArPSBuOwogICAgbGVuIC09IChz
aXplX3QpbjsKICB9Cn0KCnN0YXRpYyB2b2lkIGZpbGxfcGF0dGVybih1aW50OF90ICpidWYsIHNp
emVfdCBsZW4sIHVpbnQ4X3Qgc2VlZCkKewogIGZvciAoc2l6ZV90IGkgPSAwOyBpIDwgbGVuOyBp
KyspIHsKICAgIC8qIERlbGliZXJhdGVseSBhdm9pZCB6ZXJvIGJ5dGVzLCBzbyBhbnkgemVybyBp
cyBzdXNwaWNpb3VzLiAqLwogICAgYnVmW2ldID0gKHVpbnQ4X3QpKDEgKyAoKGkgKiAxMzF1ICsg
c2VlZCkgJSAyNTV1KSk7CiAgfQp9CgpzdGF0aWMgdm9pZCAqbWFwX2ZpbGVfYWxpZ25lZF9ybyhp
bnQgZmQsIG9mZl90IGZpbGVfb2ZmLCBzaXplX3QgbGVuKQp7CiAgLyogUmVzZXJ2ZSBlbm91Z2gg
VkEgc3BhY2UgdG8gY2hvb3NlIGEgUE1ELWFsaWduZWQgYWRkcmVzcy4gKi8KICBzaXplX3QgcmVz
ZXJ2ZV9sZW4gPSBsZW4gKyBIUEFHRTsKICB2b2lkICpyZXNlcnZlID0gbW1hcChOVUxMLCByZXNl
cnZlX2xlbiwgUFJPVF9OT05FLAogICAgICAgICAgICAgICAgICAgICAgIE1BUF9QUklWQVRFIHwg
TUFQX0FOT05ZTU9VUywgLTEsIDApOwogIGlmIChyZXNlcnZlID09IE1BUF9GQUlMRUQpIGRpZSgi
bW1hcCByZXNlcnZlIik7CgogIHVpbnRwdHJfdCBiYXNlID0gKHVpbnRwdHJfdClyZXNlcnZlOwog
IHVpbnRwdHJfdCBhbGlnbmVkID0gKGJhc2UgKyBIUEFHRSAtIDEpICYgfih1aW50cHRyX3QpKEhQ
QUdFIC0gMSk7CiAgLyogUmVsZWFzZSB0aGUgcmVzZXJ2YXRpb24sIHRoZW4gbWFwIHRoZSBmaWxl
IGF0IHRoZSBhbGlnbmVkIGFkZHJlc3MuICovCiAgaWYgKG11bm1hcChyZXNlcnZlLCByZXNlcnZl
X2xlbikgIT0gMCkgZGllKCJtdW5tYXAgcmVzZXJ2ZSIpOwoKICB2b2lkICpwID0gbW1hcCgodm9p
ZCAqKWFsaWduZWQsIGxlbiwgUFJPVF9SRUFELAogICAgICAgICAgICAgICAgIE1BUF9QUklWQVRF
IHwgTUFQX0ZJWEVEX05PUkVQTEFDRSwgZmQsIGZpbGVfb2ZmKTsKICBpZiAocCA9PSBNQVBfRkFJ
TEVEKSBkaWUoIm1tYXAgZmlsZSBmaXhlZCIpOwogIGlmICgodWludHB0cl90KXAgIT0gYWxpZ25l
ZCkgewogICAgZnByaW50ZihzdGRlcnIsICJtbWFwIGRpZCBub3QgcmV0dXJuIHJlcXVlc3RlZCBh
ZGRyZXNzXG4iKTsKICAgIGV4aXQoMik7CiAgfQogIHJldHVybiBwOwp9CgpzdGF0aWMgdm9pZCBj
b2xsYXBzZV9yb19yYW5nZShjb25zdCBjaGFyICpwYXRoLCBvZmZfdCBmaWxlX29mZikKewogIGlu
dCBmZCA9IG9wZW4ocGF0aCwgT19SRE9OTFkgfCBPX0NMT0VYRUMpOwogIGlmIChmZCA8IDApIGRp
ZSgib3BlbiBybyBmb3IgY29sbGFwc2UiKTsKCiAgdm9pZCAqcCA9IG1hcF9maWxlX2FsaWduZWRf
cm8oZmQsIGZpbGVfb2ZmLCBIUEFHRSk7CgogIC8qIEZhdWx0IGV2ZXJ5IHBhZ2UgZmlyc3Q7IE1B
RFZfQ09MTEFQU0UgZ2VuZXJhbGx5IGV4cGVjdHMgcHJlc2VudCBwYWdlcy4gKi8KICB2b2xhdGls
ZSB1aW50OF90IGFjYyA9IDA7CiAgZm9yIChzaXplX3Qgb2ZmID0gMDsgb2ZmIDwgSFBBR0U7IG9m
ZiArPSA0MDk2KSBhY2MgXj0gKCh2b2xhdGlsZSB1aW50OF90ICopcClbb2ZmXTsKICAodm9pZClh
Y2M7CgogIGlmIChtYWR2aXNlKHAsIEhQQUdFLCBNQURWX0NPTExBUFNFKSAhPSAwKSB7CiAgICBp
bnQgZSA9IGVycm5vOwogICAgZnByaW50ZihzdGRlcnIsCiAgICAgICAgICAgICJNQURWX0NPTExB
UFNFIGZhaWxlZCBhdCBmaWxlX29mZj0lamQ6ICVzXG4iCiAgICAgICAgICAgICJIaW50czogcnVu
IG9uIGJ0cmZzL2V4dDQgd2l0aCBUSFAgZW5hYmxlZCwgZW5zdXJlIG5vIHdyaXRlIGZkIGlzIG9w
ZW4sICIKICAgICAgICAgICAgImFuZCBlbnN1cmUgQ09ORklHX1JFQURfT05MWV9USFBfRk9SX0ZT
PXkuXG4iLAogICAgICAgICAgICAoaW50bWF4X3QpZmlsZV9vZmYsIHN0cmVycm9yKGUpKTsKICAg
IGVycm5vID0gZTsKICAgIGRpZSgibWFkdmlzZSBNQURWX0NPTExBUFNFIik7CiAgfQoKICBpZiAo
bXVubWFwKHAsIEhQQUdFKSAhPSAwKSBkaWUoIm11bm1hcCBjb2xsYXBzZWQiKTsKICBpZiAoY2xv
c2UoZmQpICE9IDApIGRpZSgiY2xvc2UgY29sbGFwc2UgZmQiKTsKfQoKc3RhdGljIGludCBjb3Vu
dF9iYWQoY29uc3QgdWludDhfdCAqZ290LCBjb25zdCB1aW50OF90ICp3YW50LCBzaXplX3QgbGVu
LAogICAgICAgICAgICAgICAgICAgICBzaXplX3QgKmZpcnN0X2JhZCwgc2l6ZV90ICp6ZXJvX2Nv
dW50KQp7CiAgaW50IGJhZCA9IDA7CiAgKmZpcnN0X2JhZCA9IChzaXplX3QpLTE7CiAgKnplcm9f
Y291bnQgPSAwOwogIGZvciAoc2l6ZV90IGkgPSAwOyBpIDwgbGVuOyBpKyspIHsKICAgIGlmIChn
b3RbaV0gPT0gMCkgKCp6ZXJvX2NvdW50KSsrOwogICAgaWYgKGdvdFtpXSAhPSB3YW50W2ldKSB7
CiAgICAgIGlmICgqZmlyc3RfYmFkID09IChzaXplX3QpLTEpICpmaXJzdF9iYWQgPSBpOwogICAg
ICBiYWQrKzsKICAgIH0KICB9CiAgcmV0dXJuIGJhZDsKfQoKaW50IG1haW4oaW50IGFyZ2MsIGNo
YXIgKiphcmd2KQp7CiAgY29uc3QgY2hhciAqcGF0aCA9IGFyZ2MgPiAxID8gYXJndlsxXSA6ICIu
L3RocC1vcGVuLXJlcHJvLmRhdCI7CiAgY29uc3Qgc2l6ZV90IGJhc2Vfc2l6ZSA9IGFyZ2MgPiAy
ID8gc3RydG91bGwoYXJndlsyXSwgTlVMTCwgMCkgOiA2NCAqIE1pQjsKICBjb25zdCBzaXplX3Qg
YXBwZW5kX3NpemUgPSBhcmdjID4gMyA/IHN0cnRvdWxsKGFyZ3ZbM10sIE5VTEwsIDApIDogMTYg
KiBLaUI7CiAgY29uc3QgaW50IGl0ZXJzID0gYXJnYyA+IDQgPyBhdG9pKGFyZ3ZbNF0pIDogMjAw
OwoKICBpZiAoYmFzZV9zaXplIDwgNCAqIEhQQUdFKSB7CiAgICBmcHJpbnRmKHN0ZGVyciwgImJh
c2Vfc2l6ZSBtdXN0IGJlIGF0IGxlYXN0IDhNaUJcbiIpOwogICAgcmV0dXJuIDI7CiAgfQoKICBw
cmludGYoInBhdGg9JXMgYmFzZV9zaXplPSV6dSBhcHBlbmRfc2l6ZT0lenUgaXRlcnM9JWRcbiIs
CiAgICAgICAgIHBhdGgsIGJhc2Vfc2l6ZSwgYXBwZW5kX3NpemUsIGl0ZXJzKTsKCiAgdWludDhf
dCAqYmFzZSA9IG1hbGxvYyhIUEFHRSk7CiAgdWludDhfdCAqd2FudCA9IG1hbGxvYyhhcHBlbmRf
c2l6ZSk7CiAgdWludDhfdCAqZ290ID0gbWFsbG9jKGFwcGVuZF9zaXplKTsKICBpZiAoIWJhc2Ug
fHwgIXdhbnQgfHwgIWdvdCkgZGllKCJtYWxsb2MiKTsKICBmaWxsX3BhdHRlcm4oYmFzZSwgSFBB
R0UsIDcpOwogIGZpbGxfcGF0dGVybih3YW50LCBhcHBlbmRfc2l6ZSwgOTEpOwoKICBpbnQgZmQg
PSBvcGVuKHBhdGgsIE9fQ1JFQVQgfCBPX1RSVU5DIHwgT19SRFdSIHwgT19DTE9FWEVDLCAwNjY2
KTsKICBpZiAoZmQgPCAwKSBkaWUoImNyZWF0ZSIpOwogIGZvciAob2ZmX3Qgb2ZmID0gMDsgb2Zm
IDwgKG9mZl90KWJhc2Vfc2l6ZTsgb2ZmICs9IChvZmZfdClIUEFHRSkgewogICAgeHdyaXRlX2Z1
bGwoZmQsIGJhc2UsIEhQQUdFLCBvZmYpOwogIH0KICBpZiAoZnN5bmMoZmQpICE9IDApIGRpZSgi
ZnN5bmMgaW5pdGlhbCIpOwogIGlmIChjbG9zZShmZCkgIT0gMCkgZGllKCJjbG9zZSBpbml0aWFs
Iik7CgogIGNvbnN0IG9mZl90IGFwcGVuZF9vZmYgPSAob2ZmX3QpYmFzZV9zaXplOwogIGJvb2wg
cmVwcm9kdWNlZCA9IGZhbHNlOwoKICBmb3IgKGludCBpdGVyID0gMDsgaXRlciA8IGl0ZXJzOyBp
dGVyKyspIHsKICAgIC8qIFJldHVybiB0byB0aGUgb3JpZ2luYWwgc2l6ZSBhbmQgZHVyYWJsZSBi
YXNlIGNvbnRlbnRzLiAqLwogICAgZmQgPSBvcGVuKHBhdGgsIE9fUkRXUiB8IE9fQ0xPRVhFQyk7
CiAgICBpZiAoZmQgPCAwKSBkaWUoIm9wZW4gcmVzZXQiKTsKICAgIGlmIChmdHJ1bmNhdGUoZmQs
IChvZmZfdCliYXNlX3NpemUpICE9IDApIGRpZSgiZnRydW5jYXRlIHJlc2V0Iik7CiAgICBpZiAo
ZnN5bmMoZmQpICE9IDApIGRpZSgiZnN5bmMgcmVzZXQiKTsKICAgIGlmIChjbG9zZShmZCkgIT0g
MCkgZGllKCJjbG9zZSByZXNldCIpOwoKICAgIC8qIENyZWF0ZSByZWFkLW9ubHkgZmlsZSBUSFBz
LCB0aGVuIG9wZW4tZm9yLXdyaXRlIGFuZCBkaXJ0eSBhcHBlbmRlZCBkYXRhLiAqLwogICAgY29s
bGFwc2Vfcm9fcmFuZ2UocGF0aCwgMCk7CgogICAgZmQgPSBvcGVuKHBhdGgsIE9fUkRXUiB8IE9f
Q0xPRVhFQyk7CiAgICBpZiAoZmQgPCAwKSBkaWUoIm9wZW4gYXBwZW5kIik7CiAgICB4d3JpdGVf
ZnVsbChmZCwgd2FudCwgYXBwZW5kX3NpemUsIGFwcGVuZF9vZmYpOwogICAgLyogRG8gbm90IGZz
eW5jLiAgVGhlIGRpcnR5IHBhZ2UtY2FjaGUgc3RhdGUgaXMgd2hhdCB3ZSBhcmUgdGVzdGluZy4g
Ki8KICAgIGlmIChjbG9zZShmZCkgIT0gMCkgZGllKCJjbG9zZSBhcHBlbmQiKTsKCiAgICAvKiBS
ZWluc3RhbGwgYSBmaWxlIFRIUCB3aGlsZSBubyB3cml0ZSBmZCBpcyBvcGVuLiAgVGhpcyBpcyB0
aGUgc3RhdGUgdGhhdAogICAgICogbWFrZXMgdGhlIG5leHQgd3JpdGUtb3BlbiBwdXJnZSB0aGUg
bWFwcGluZy4gKi8KICAgIGNvbGxhcHNlX3JvX3JhbmdlKHBhdGgsIDApOwoKICAgIGZkID0gb3Bl
bihwYXRoLCBPX1JEV1IgfCBPX0NMT0VYRUMpOwogICAgaWYgKGZkIDwgMCkgZGllKCJvcGVuIHRy
aWdnZXIiKTsKICAgIGlmIChjbG9zZShmZCkgIT0gMCkgZGllKCJjbG9zZSB0cmlnZ2VyIik7Cgog
ICAgaW50IHJmZCA9IG9wZW4ocGF0aCwgT19SRE9OTFkgfCBPX0NMT0VYRUMpOwogICAgaWYgKHJm
ZCA8IDApIGRpZSgib3BlbiByZWFkYmFjayIpOwogICAgeHJlYWRfZnVsbChyZmQsIGdvdCwgYXBw
ZW5kX3NpemUsIGFwcGVuZF9vZmYpOwogICAgaWYgKGNsb3NlKHJmZCkgIT0gMCkgZGllKCJjbG9z
ZSByZWFkYmFjayIpOwoKICAgIHNpemVfdCBmaXJzdF9iYWQsIHplcm9fY291bnQ7CiAgICBpbnQg
YmFkID0gY291bnRfYmFkKGdvdCwgd2FudCwgYXBwZW5kX3NpemUsICZmaXJzdF9iYWQsICZ6ZXJv
X2NvdW50KTsKICAgIGlmIChiYWQpIHsKICAgICAgcHJpbnRmKCJSRVBST0RVQ0VEIGl0ZXI9JWQg
YmFkX2J5dGVzPSVkIGZpcnN0X2JhZD0lenUgemVyb19jb3VudD0lenUgYXBwZW5kX29mZj0lamRc
biIsCiAgICAgICAgICAgICBpdGVyLCBiYWQsIGZpcnN0X2JhZCwgemVyb19jb3VudCwgKGludG1h
eF90KWFwcGVuZF9vZmYpOwogICAgICBwcmludGYoImZpcnN0IDY0IGdvdDoiKTsKICAgICAgZm9y
IChpbnQgaSA9IDA7IGkgPCA2NCAmJiBpIDwgKGludClhcHBlbmRfc2l6ZTsgaSsrKSBwcmludGYo
IiAlMDJ4IiwgZ290W2ldKTsKICAgICAgcHJpbnRmKCJcbmZpcnN0IDY0IHdhbnQ6Iik7CiAgICAg
IGZvciAoaW50IGkgPSAwOyBpIDwgNjQgJiYgaSA8IChpbnQpYXBwZW5kX3NpemU7IGkrKykgcHJp
bnRmKCIgJTAyeCIsIHdhbnRbaV0pOwogICAgICBwcmludGYoIlxuIik7CiAgICAgIHJlcHJvZHVj
ZWQgPSB0cnVlOwogICAgICBicmVhazsKICAgIH0KCiAgICBpZiAoKGl0ZXIgJSAxMCkgPT0gMCkg
cHJpbnRmKCJpdGVyPSVkIG9rXG4iLCBpdGVyKTsKICB9CgogIGlmICghcmVwcm9kdWNlZCkKICAg
IHByaW50Zigibm8gY29ycnVwdGlvbiBvYnNlcnZlZCBhZnRlciAlZCBpdGVyYXRpb25zXG4iLCBp
dGVycyk7CgogIHJldHVybiByZXByb2R1Y2VkID8gMSA6IDA7Cn0K
--0000000000004808e406557b8afa
Content-Type: application/x-patch; 
	name="thp-open-writeback-before-purge.patch"
Content-Disposition: attachment; 
	filename="thp-open-writeback-before-purge.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mr0w4sne1>
X-Attachment-Id: f_mr0w4sne1

LS0tIGEvZnMvb3Blbi5jCTIwMjYtMDYtMjUgMTI6MjI6NDYuMjc1NDUxNDMwIC0wNDAwCisrKyBi
L2ZzL29wZW4uYwkyMDI2LTA2LTI1IDEyOjIyOjQ2LjI5ODQ1MTY5MCAtMDQwMApAQCAtOTkzLDcg
Kzk5MywyMSBAQAogCQlpZiAoZmlsZW1hcF9ucl90aHBzKGlub2RlLT5pX21hcHBpbmcpKSB7CiAJ
CQlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZyA9IGlub2RlLT5pX21hcHBpbmc7CiAKLQkJ
CWZpbGVtYXBfaW52YWxpZGF0ZV9sb2NrKGlub2RlLT5pX21hcHBpbmcpOworCQkJZmlsZW1hcF9p
bnZhbGlkYXRlX2xvY2sobWFwcGluZyk7CisJCQkvKgorCQkJICogdHJ1bmNhdGVfaW5vZGVfcGFn
ZXMoKSBpbnZhbGlkYXRlcyBkaXJ0eSBmb2xpb3MgYnkKKwkJCSAqIGNhbmNlbGxpbmcgdGhlaXIg
ZGlydHkgc3RhdGUuICBUaGF0IGlzIHNhZmUgZm9yIGEgdHJ1ZQorCQkJICogdHJ1bmNhdGUgYWZ0
ZXIgdGhlIGZpbGVzeXN0ZW0gaGFzIGRlY2lkZWQgdGhlIGRhdGEgaXMgbm8KKwkJCSAqIGxvbmdl
ciBwYXJ0IG9mIHRoZSBmaWxlLCBidXQgdGhpcyBvcGVuLXRpbWUgVEhQIHB1cmdlIGlzCisJCQkg
KiBub3QgYSB0cnVuY2F0ZTogaXQgaXMgb25seSBhIGNhY2hlLW1hbmFnZW1lbnQgc3RlcCBiZWZv
cmUKKwkJCSAqIHBlcm1pdHRpbmcgd3JpdGVzLiAgUHJlc2VydmUgYW55IGRpcnR5IGRhdGEgYWxy
ZWFkeSBpbiB0aGUKKwkJCSAqIG1hcHBpbmcgYmVmb3JlIGRyb3BwaW5nIHRoZSBjYWNoZS4KKwkJ
CSAqLworCQkJZXJyb3IgPSBmaWxlbWFwX3dyaXRlX2FuZF93YWl0KG1hcHBpbmcpOworCQkJaWYg
KGVycm9yKSB7CisJCQkJZmlsZW1hcF9pbnZhbGlkYXRlX3VubG9jayhtYXBwaW5nKTsKKwkJCQln
b3RvIGNsZWFudXBfYWxsOworCQkJfQogCQkJLyoKIAkJCSAqIHVubWFwX21hcHBpbmdfcmFuZ2Ug
anVzdCBuZWVkIHRvIGJlIGNhbGxlZCBvbmNlCiAJCQkgKiBoZXJlLCBiZWNhdXNlIHRoZSBwcml2
YXRlIHBhZ2VzIGlzIG5vdCBuZWVkIHRvIGJlCkBAIC0xMDAyLDcgKzEwMTYsNyBAQAogCQkJICov
CiAJCQl1bm1hcF9tYXBwaW5nX3JhbmdlKG1hcHBpbmcsIDAsIDAsIDApOwogCQkJdHJ1bmNhdGVf
aW5vZGVfcGFnZXMobWFwcGluZywgMCk7Ci0JCQlmaWxlbWFwX2ludmFsaWRhdGVfdW5sb2NrKGlu
b2RlLT5pX21hcHBpbmcpOworCQkJZmlsZW1hcF9pbnZhbGlkYXRlX3VubG9jayhtYXBwaW5nKTsK
IAkJfQogCX0KIAo=
--0000000000004808e406557b8afa--
