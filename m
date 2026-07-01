Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9404F39A808
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934540; cv=pass; b=VjvnkPg0y23ZHKMAhQNq0kJPuFnw6JNNMDLB/WkrOjqbFU4Gw/rQh51UCL9Gop7Mpu7RE5+MIEQ+CqaFa5n9NKgtAXgO2ZcMDvBD/aPNW+AVnOuCH/8cSMNgHaqOY3wmBSYrvXyZjn0CASNSwKDR7a1hfiGHBdQtubys3FwweVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934540; c=relaxed/simple;
	bh=W6CJBvffePQ1xTgxagHeLlloRE/H6DklNbAaM7XMEes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZWXbR5XxpWJJa8wgPDWxxLVOBnkeZ1l1Ho7empknP3p05lRcU5GyAtZdEAwFaoe/gibCjUHg1CejVOSlpcqlnB1CumEtIWXMKe5ZGao6HKwQJFhE94bc1dn3ntGiqTjmDqdBPS5RGFtzlMBWF1qJBeHsPMRsdnXR9Y4f2CWy/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkWeW4MO; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkWeW4MO"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-474560436c3so959822f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 12:35:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782934537; cv=none;
        d=google.com; s=arc-20260327;
        b=eIwE+LQqOQd9uorJpSWHe6E7qHF4tz0DzaU4DcoDFxxh8a00ZvWszm/s1PLx64k1gk
         gwNWYLOM1DCaQdZb6Jfeb2+WixFmij5fUCTJCEoG3P+CNqSWOspzJnlofXk52xgn9j1A
         RFacV0yn26kJ/4BNGk4pDCccRDhxBVduAj1/x79hUDtpMnQ+lUU3sPXPwJPKDtjmy8aU
         CiHwrDYMKQcBi57Sn+WvwK5H9bV9IWLPXTi+/uFNNKl/o2/+XhTHyqBGTIdUo7K26MZj
         aS0HrxKBWlU5qriaS+NLkG8Mo6YskPV4UKz6hBoxDBbsiJtuuBRJmIlUeOttCPkthmR2
         20yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pGGDxr3N3ZHTVGBYFBwUmfiD25X2IVkVBZj7x5VdJpQ=;
        fh=snFWi6iuIncj0fPh4Klc0nINasY+qLirQbTpiqQ6Br4=;
        b=XXe5urhY6nk/qJLO9JxJTELXAmswXlUoBvo9YSw6NZ5lOut12t9HzKxURH2x0Wa2Kt
         hllJbCOrWBKVPTN+uN0Ji28SZP6WFIHjigXaDDSbRDVPoR8IU3fcjWK3rWhYYc7vUgkf
         lJyFZu2KHtt40Ttvwmo/a2TLxq+yN9YXzQvtrsfWZYTHiS0hCRhUa4KGHllHuEoXG+I/
         HEFuLE52UWNcvJRn6mnkAMgi1HBMhMtJzCjTLo8zTOlhYtWz1hg7pZaGVhpqZ7xNKWoG
         sa4YLxMfBGxGC3N2G+fxGOvDWJh3u2SibhOIbV5PnVn9QnBDOVvjKMerYkSHTjzGfymR
         4irg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782934537; x=1783539337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGGDxr3N3ZHTVGBYFBwUmfiD25X2IVkVBZj7x5VdJpQ=;
        b=dkWeW4MOYHjKBIGKBMixuDTcGthkx7tZXP9qzgxCHl0Bhnw7UPL730ubvrQwSAEbaw
         N1P6VfwhITJJgbnUb9K6TjMyMC5EMPXVByrQJSNCizIMoewbHJQxE9Boi2WHOZ2HoOtU
         8vsQigsZL8uiD07U8I1r8mMD5o2u+HH7JuIGZZ1biooJQwvQKXDMI3eMP+qF2HyZIqtu
         Er8v6T7q1EY5r/kHM9q+VWDlBnCeFjUFZYRTBD5dyqKKXbr/IZpfdMyqA+cSdk1+EvMl
         ZHrcGQWI7znAwTXcwS6VvN9n4vzlYri5UNI0P1Zd3pezzoouXNDwkzrg5x4ha3faPdn4
         hEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934537; x=1783539337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pGGDxr3N3ZHTVGBYFBwUmfiD25X2IVkVBZj7x5VdJpQ=;
        b=e16vHSA/twjVt0ulsmQdoDEmTQJyge05ePMik1liizy3htEjNuJpUV4hKtfGkL3Q4T
         v4riVac+ffMX7kgVMOFllI7Lc+ofeJg+btoJIdULEwo7oNaRWCFP+p8FWsO1AFndFu6L
         MvkjCLgaEwEnRJFU7cUrBHNOPTTkuDIh+ScRSyXWvUomSrqypMOr+eP3amrck/7rmafb
         sJGC5g9To3rX9/JUTSUJQbB1WphKlvKUcxkJAW+POZB/a67wcPuD1LXYBhkdHCqWQexE
         XI6lo5YMchzABHVpEzF0aTsjwGhQ97H/+weuVSeHNLQu9VXrtxdcZw4GpOtbKhz/DilK
         xEMw==
X-Forwarded-Encrypted: i=1; AHgh+RrolkoQ2uloa8D2zTYAu0dd1TzMAjjcwDxsgCKfofFD5E4frmpBNJjTQjyUg4MR8g03UN8Ft0Mh+55VsuVR@vger.kernel.org
X-Gm-Message-State: AOJu0YzXBhKDnOy8Jk6iCGl59qwF6MubgdhRIJ1r5ldZEY3s2Mapbwrl
	FDY7grl02XxgPXXd06k2AJBuH9x72vfFI3mkOso4JDDA4UYdwwaxlH8lUmYHJ/Te+Ro6YeCSV4G
	FbXgPglOS/m3Pyk0izOHmbLXkFvxRogU=
X-Gm-Gg: AfdE7claKhk2SyhtklMuhLAsg4Iu2iRTJwRQrGTqkoVaZYfdfEPNkpAEZVGUcP7fEN0
	8fezAAbDy55CMKhcD8K+BRd2bORCkSEaPg+hSkczmmR2FzUmZq61/wLHiYMcrRC1e3RsyBjgvqW
	OA9zuy0Id0AhPraDw2hcJebT1qhB2GFoi3Quen26VGZqVXPok5N/7oApBtizbYuoF6cuz/FOGEn
	+4yqaadl/5EBM6znkl+Efvlm7w+gT/5kZSv8+t1BQTZ5HZa71Hx1xtlwVCfqEPUShLUVZyR7f+f
	RuK0c69GYhxENcgMIDyAplr6g1OIhLALHAH7OfEsgnIVxC4i0a/n
X-Received: by 2002:a05:6000:4818:b0:474:9991:60d0 with SMTP id
 ffacd0b85a97d-477aeb5bef7mr3461724f8f.12.1782934536936; Wed, 01 Jul 2026
 12:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701033253.46420-1-changfengnan@bytedance.com>
 <20260701033253.46420-4-changfengnan@bytedance.com> <akT4tJzFSfrBxqdq@infradead.org>
In-Reply-To: <akT4tJzFSfrBxqdq@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 1 Jul 2026 12:35:24 -0700
X-Gm-Features: AVVi8CeXAJXVfUIyr35lv5pL20q_ALlPEdtXwqos7WTDEDHtloeaTCi_lAygHvs
Message-ID: <CAJnrk1Y3yPeXBeBNo+DjTt8eRN-mc2F9apBCUn+j=GV7GMzi4g@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] iomap: add simple dio path for small direct I/O
To: Christoph Hellwig <hch@infradead.org>
Cc: Fengnan Chang <changfengnan@bytedance.com>, brauner@kernel.org, djwong@kernel.org, 
	ojaswin@linux.ibm.com, dgc@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lidiangang@bytedance.com, 
	pankaj.raghav@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 4:23=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> We'll need to sort out the interaction with the iomap_next work, though.
>
> Joanne, is it ok to get this in first and have Fengnan help your with
> the interactions due to the open coded iomap_begin/end calls?
>

That sounds good, I'll rebase the next version onto these changes.

I think it ends up being pretty simple to get it integrated since
->iomap_next already contains the logic to only begin the mapping at
the start and only finish the mapping when the iter has been fully
consumed, eg

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 3ef5e9adca87..e654ec135d54 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -1035,7 +1035,7 @@ iomap_dio_simple_supported(struct kiocb *iocb,
struct iov_iter *iter,
  */
 static ssize_t
 iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
-                const struct iomap_ops *ops, void *private,
+                iomap_next_fn iomap_next, void *private,
                 unsigned int dio_flags)
 {
        struct inode *inode =3D file_inode(iocb->ki_filp);
@@ -1062,11 +1062,11 @@ iomap_dio_simple(struct kiocb *iocb, struct
iov_iter *iter,

        inode_dio_begin(inode);

-       ret =3D ops->iomap_begin(inode, iomi.pos, count, iomi.flags,
-                              &iomi.iomap, &iomi.srcmap);
-       if (ret) {
+       ret =3D iomap_iter(&iomi, iomap_next);
+       if (ret <=3D 0) {
                inode_dio_end(inode);
-               return ret;
+               /* ret of 0 means no mapping, which should never happen */
+               return ret ? ret : -EFAULT;
        }

        if (iomi.iomap.type !=3D IOMAP_MAPPED ||
@@ -1125,14 +1125,17 @@ iomap_dio_simple(struct kiocb *iocb, struct
iov_iter *iter,
                WRITE_ONCE(iocb->private, bio);
        }

-       if (ops->iomap_end)
-               ops->iomap_end(inode, iomi.pos, count, count, iomi.flags,
-                              &iomi.iomap);
+       iomap_iter_advance(&iomi, count);
+       /*
+        * ends the mapping if the mapping needs to be ended. no new mappin=
gs
+        * are fetched since the entire range of the iter has been consumed
+        */
+       iomap_iter(&iomi, iomap_next);

        if (!wait_for_completion) {
                bio->bi_end_io =3D iomap_dio_simple_end_io;
                submit_bio(bio);
-               trace_iomap_dio_rw_queued(inode, iomi.pos, count);
+               trace_iomap_dio_rw_queued(inode, iocb->ki_pos, count);
                return -EIOCBQUEUED;
        }

@@ -1144,9 +1147,12 @@ iomap_dio_simple(struct kiocb *iocb, struct
iov_iter *iter,
 out_bio_put:
        bio_put(bio);
 out_iomap_end:
-       if (ops->iomap_end)
-               ops->iomap_end(inode, iomi.pos, count, 0, iomi.flags,
-                              &iomi.iomap);
+       /*
+        * on failure, iter was never advanced. ->iomap_next() will know th=
at 0
+        * bytes have been processed and the mapping will be ended with no =
next
+        * mapping fetched
+        */
+       iomap_iter(&iomi, iomap_next);
        inode_dio_end(inode);
        return ret;
 }

Thanks,
Joanne
