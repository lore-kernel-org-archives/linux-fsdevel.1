Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B1F351C20
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358612; cv=none; b=Cf8Kgb6AVc4MXdiyzUPRHwr2jbEVo4qoLH0oOOM+5pPUm1gSeVIYwPX29F+DZ89USx5JRzUgSRghon0CPS+PeazN1u1nzqEnvOo7gMwZ538/Zk11X7dpiULW1hSYbVIxd+0V0mHuWOsxhyJus2viZ5Yk64V273N3g/T751UzytE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358612; c=relaxed/simple;
	bh=Nzg8BzFlymzEdQ6TohyGoGXvXkcgVYApStrQfcekNQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ssZ1/LZsyTyCNQFM+LzjLBKhI80oU+5KenA+MPh6iZSMUPUboFBXdiKW8XEeffZ3CZ3XQFHKfGg1pgBK65SxDdvv5eeKDy5HsN2PXf8hKPrSxfrL7QR+FB4CHCQCrA2R7bYoEnC0vELroxUa3/cbqO8PzNhFF5OX/NCHCvCclXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cx+8d04m; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx+8d04m"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so132982305e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 23:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777358609; x=1777963409; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwBnmQWAqTUuuhBm4QcKpMELVCqKk31DVWsSwyob1/c=;
        b=cx+8d04mDNNMLGFOMHOWWCatvbHcCEsPfkupJt1WCNJu+F30HVBqvv3xVJkJuPzbMm
         9ygZqwXNhmSplZbOgAiKU35Jo3T74PAHGoBCWjXFuWQZDCgVUY0i1XkWwDigrk2+JkMP
         uq9k3PqW2GLY9tbdJGSj3cPuIxV5CcVh06jTWg89Qf8++pUYizviMUxplMV3gLiZI70b
         2DWBcMvyS+27+5MpNqSl18xOgGIn3X23MajdDoBx9GEEcrRWxffm/wJe0roLCKduGru6
         0CWhncTI+S7reBP2iHgaqU08u4itKTShGBKDuPNDdIa/RjEKnnVh6Pf+z+3JnAz9uJWP
         YGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777358609; x=1777963409;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwBnmQWAqTUuuhBm4QcKpMELVCqKk31DVWsSwyob1/c=;
        b=rnkT0krvEwKFi4W3MiqQO2jLUZLCNdX4tzNIqiskFpv2YjRY5dXJNGXnVPfX53+m+0
         Zw3I601VjwgTFoMF6xVvRm95CiCfN0Yy32XHYN4LgeffrwLsXoQJVkI+gKhO1YzeA6rc
         RLFHEgzS4TOjwMU1k5OFtDNKvN9NicEuXelwPSTlbT2ocs3SNN4b8ouuAkfRbzGW8/Jr
         eLWRVw7VIP7zbwyz2JjQI1wa6mizfpbK9L6EFvDpInk4mK7Yx5BGg/c05Jox/cz/0QaG
         qD6snXYxt3K7fVzntUlzxZxKg1iRO8/ribNGajBUhlGYvTqDJ0OoEl55Dh+avidxTTnQ
         /InA==
X-Gm-Message-State: AOJu0YxXaqdi/F4V/bO3dwgj4r0Noohdz74lrPcHcFn99DFV5AF4XcWf
	qNuALV3Ubp2YO4tooFDiAqwU+UujoID7sX36gRKHB1EYiLqh43WE3SJHRT4H6Q==
X-Gm-Gg: AeBDiesJ57Bt4WoqK+3LjNF+e296m1zURWcqvFFRVqaaIWkKe2fQo7ZhnkvdlGjSl8O
	VQwQCtHbLUlqAhb2tdB6NEpfJdgZIkvBZ7WqXOyNR8UolPe/fZZiWa6iiKCIjDaClYuo1aRLWi/
	T6aNdCpLcxRLlcK5x3Su9p8r49eevDt6lsZAfxWyAmXQfk1n2lGpYVviEMp+5w8DI8nsTm4QGIG
	rOfb1nSnwW8JM1fxB51mTtIBX2vyc2DZQ47QXn2TkitFTHKC4uIbwU1kvPwr6hn9S8sXAJVspop
	hc4GXtJyJhX3np/RP45SkgaUjS2a+cWicxW0+efyV3qpx25HDlk23P3k9zhSVuzorl1EzUiIhDj
	RTRgCo5t/soVHoxURbx4cWpSF8Qe9/ebrzpdNxkUYJuYD8vsbg6jy6+aA1cl3qZSc6Wh9aHTY5O
	6vMyYO91Ni+Y/e2yYS30qANLniI1hRaA==
X-Received: by 2002:a05:600c:1c18:b0:488:e7e4:8425 with SMTP id 5b1f17b1804b1-48a77b0ec86mr28609295e9.23.1777358609145;
        Mon, 27 Apr 2026 23:43:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77c24ca0sm28497935e9.14.2026.04.27.23.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 23:43:28 -0700 (PDT)
Date: Tue, 28 Apr 2026 09:43:25 +0300
From: Dan Carpenter <error27@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] ntfs: update runlist handling and cluster allocator
Message-ID: <afBXDaMfpS1mao5_@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Namjae Jeon,

Commit 11ccc9107dc4 ("ntfs: update runlist handling and cluster
allocator") from Feb 13, 2026 (linux-next), leads to the following
Smatch static checker warning:

	fs/ntfs/bitmap.c:268 __ntfs_bitmap_set_bits_in_run()
	warn: passing a valid pointer to 'PTR_ERR'

fs/ntfs/bitmap.c
    120 int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
    121                 const s64 count, const u8 value, const bool is_rollback)
    122 {
    123         s64 cnt = count;
    124         pgoff_t index, end_index;
    125         struct address_space *mapping;
    126         struct folio *folio;
    127         u8 *kaddr;
    128         int pos, len;
    129         u8 bit;
    130         struct ntfs_inode *ni = NTFS_I(vi);
    131         struct ntfs_volume *vol = ni->vol;
    132 
    133         ntfs_debug("Entering for i_ino 0x%llx, start_bit 0x%llx, count 0x%llx, value %u.%s",
    134                         ni->mft_no, (unsigned long long)start_bit,
    135                         (unsigned long long)cnt, (unsigned int)value,
    136                         is_rollback ? " (rollback)" : "");
    137 
    138         if (start_bit < 0 || cnt < 0 || value > 1)
    139                 return -EINVAL;
    140 
    141         /*
    142          * Calculate the indices for the pages containing the first and last
    143          * bits, i.e. @start_bit and @start_bit + @cnt - 1, respectively.
    144          */
    145         index = start_bit >> (3 + PAGE_SHIFT);
    146         end_index = (start_bit + cnt - 1) >> (3 + PAGE_SHIFT);
    147 
    148         /* Get the page containing the first bit (@start_bit). */
    149         mapping = vi->i_mapping;
    150         folio = read_mapping_folio(mapping, index, NULL);
    151         if (IS_ERR(folio)) {
    152                 if (!is_rollback)
    153                         ntfs_error(vi->i_sb,
    154                                 "Failed to map first page (error %li), aborting.",
    155                                 PTR_ERR(folio));
    156                 return PTR_ERR(folio);
    157         }
    158 
    159         folio_lock(folio);
    160         kaddr = kmap_local_folio(folio, 0);
    161 
    162         /* Set @pos to the position of the byte containing @start_bit. */
    163         pos = (start_bit >> 3) & ~PAGE_MASK;
    164 
    165         /* Calculate the position of @start_bit in the first byte. */
    166         bit = start_bit & 7;
    167 
    168         /* If the first byte is partial, modify the appropriate bits in it. */
    169         if (bit) {
    170                 u8 *byte = kaddr + pos;
    171 
    172                 if (ni->mft_no == FILE_Bitmap)
    173                         ntfs_set_lcn_empty_bits(vol, index, value, min_t(s64, 8 - bit, cnt));
    174                 while ((bit & 7) && cnt) {
    175                         cnt--;
    176                         if (value)
    177                                 *byte |= 1 << bit++;
    178                         else
    179                                 *byte &= ~(1 << bit++);
    180                 }
    181                 /* If we are done, unmap the page and return success. */
    182                 if (!cnt)
    183                         goto done;
    184 
    185                 /* Update @pos to the new position. */
    186                 pos++;
    187         }
    188         /*
    189          * Depending on @value, modify all remaining whole bytes in the page up
    190          * to @cnt.
    191          */
    192         len = min_t(s64, cnt >> 3, PAGE_SIZE - pos);
    193         memset(kaddr + pos, value ? 0xff : 0, len);
    194         cnt -= len << 3;
    195         if (ni->mft_no == FILE_Bitmap)
    196                 ntfs_set_lcn_empty_bits(vol, index, value, len << 3);
    197 
    198         /* Update @len to point to the first not-done byte in the page. */
    199         if (cnt < 8)
    200                 len += pos;
    201 
    202         /* If we are not in the last page, deal with all subsequent pages. */
    203         while (index < end_index) {
    204                 if (cnt <= 0)
    205                         goto rollback;

When we hit this goto then "folio" isn't set to an error pointer.

    206 
    207                 /* Update @index and get the next folio. */
    208                 folio_mark_dirty(folio);
    209                 folio_unlock(folio);
    210                 kunmap_local(kaddr);
    211                 folio_put(folio);
    212                 folio = read_mapping_folio(mapping, ++index, NULL);
    213                 if (IS_ERR(folio)) {
    214                         ntfs_error(vi->i_sb,
    215                                    "Failed to map subsequent page (error %li), aborting.",
    216                                    PTR_ERR(folio));
    217                         goto rollback;
    218                 }
    219 
    220                 folio_lock(folio);
    221                 kaddr = kmap_local_folio(folio, 0);
    222                 /*
    223                  * Depending on @value, modify all remaining whole bytes in the
    224                  * page up to @cnt.
    225                  */
    226                 len = min_t(s64, cnt >> 3, PAGE_SIZE);
    227                 memset(kaddr, value ? 0xff : 0, len);
    228                 cnt -= len << 3;
    229                 if (ni->mft_no == FILE_Bitmap)
    230                         ntfs_set_lcn_empty_bits(vol, index, value, len << 3);
    231         }
    232         /*
    233          * The currently mapped page is the last one.  If the last byte is
    234          * partial, modify the appropriate bits in it.  Note, @len is the
    235          * position of the last byte inside the page.
    236          */
    237         if (cnt) {
    238                 u8 *byte;
    239 
    240                 WARN_ON(cnt > 7);
    241 
    242                 bit = cnt;
    243                 byte = kaddr + len;
    244                 if (ni->mft_no == FILE_Bitmap)
    245                         ntfs_set_lcn_empty_bits(vol, index, value, bit);
    246                 while (bit--) {
    247                         if (value)
    248                                 *byte |= 1 << bit;
    249                         else
    250                                 *byte &= ~(1 << bit);
    251                 }
    252         }
    253 done:
    254         /* We are done.  Unmap the folio and return success. */
    255         folio_mark_dirty(folio);
    256         folio_unlock(folio);
    257         kunmap_local(kaddr);
    258         folio_put(folio);
    259         ntfs_debug("Done.");
    260         return 0;
    261 rollback:
    262         /*
    263          * Current state:
    264          *        - no pages are mapped
    265          *        - @count - @cnt is the number of bits that have been modified
    266          */
    267         if (is_rollback)
--> 268                 return PTR_ERR(folio);
                               ^^^^^^^^^^^^^^^
Warning here.

    269         if (count != cnt)
    270                 pos = __ntfs_bitmap_set_bits_in_run(vi, start_bit, count - cnt,
    271                                 value ? 0 : 1, true);
    272         else
    273                 pos = 0;
    274         if (!pos) {
    275                 /* Rollback was successful. */
    276                 ntfs_error(vi->i_sb,
    277                         "Failed to map subsequent page (error %li), aborting.",
    278                         PTR_ERR(folio));
    279         } else {
    280                 /* Rollback failed. */
    281                 ntfs_error(vi->i_sb,
    282                         "Failed to map subsequent page (error %li) and rollback failed (error %i). Aborting and leaving inconsistent metadata. Unmount and run chkdsk.",
    283                         PTR_ERR(folio), pos);
    284                 NVolSetErrors(NTFS_SB(vi->i_sb));
    285         }
    286         return PTR_ERR(folio);
    287 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
