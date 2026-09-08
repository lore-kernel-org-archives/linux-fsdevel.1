Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF51B87C0
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788834755; cv=pass; b=b9q6Nur7WBnVqBxG1xQhVz/WnBeLmVUi9hhSaM273aCVS3mfxB/tMKZIsknscKU96pI97gp7fsmTm24yiUyZXj2lyjTPgir98RiowOm2hhfkYpYmT9jLmgIr5EtgWUBwEHG6sBPuwtneFhad7xWxwCK7Ps5I8lzFjnw4exbT/GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788834755; c=relaxed/simple;
	bh=IhkE7Kgsea6Jppo7O0QUJgWybWjjjQxA9sEPbHI1Ymw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1lMgPJb/teE4GsI0urOeOef8EbBN2hIxwsK7gfFLYjVmzRycxoglqNIPRmDkf/oP023rjA2Ka/FKwBYZHrLC1DKer3xCd5h46aaAs7s0/hYBAVEoSHFzy2hUKrysymjj8g9GYl0lDAmPqdOLpLkUghsVRqmPhbfr7/A72lexmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=N2Tn5koy; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="N2Tn5koy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc891373e0so42627375ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 19:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788834752; cv=none;
        d=google.com; s=arc-20260327;
        b=fxogqJg98O/Dzc8j1oc4GGQiHHOh8hFQm/o+kob/2HBmVG2zRQRxVjUxtdM1CXA/ir
         ELkKDOLAexFW8hQ9YGZyzanxzHppFgvh3M3+OeCRo3IqriCdQNX4hJB3vc5OrH39WokZ
         64/QXqqru0kN25047cu2m/RzANFmbz8svWY26UEdhZuo1Hg4bR0Z+z2pb9dVhtmk2itV
         L+kTPf3x3Fqds5Ga6EPwXA8CYTcG9fF/dGBmCsIudF+bvZ+14gcV8CNy4y9OCrA+FOHf
         2tmv8i5WOrpQ3DRP2IgHHnXQ/qfjkBRmnkW+DFMYCUspKBmEumfnOy6O68KOm6sJljF9
         62yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QQFakzH5ezRHmdy66K1wxZ0Prtbhmc8e0YvL+1cXyNI=;
        fh=uWx8bsqV7Cas20OtcNa6MdjghmXzyWMwM0aY0B9AFm8=;
        b=Jf95oobTCrlW5P4GxUQfpzTRsJ16hTtOxmMt7b54BMXA7iuA9rwVgun4NmHAiGxc/C
         in9Yvfa7EM3SuvZczhFcc6DJ3sy8L3CAPUTvhv6vtAyxpKgTLckOGx23/kClyhwOozFX
         7HRVrpQLYZe/ej5nOmOyp02Z7C2nOm9SvgtiRYz+9FbTAJh4+UxkhiytUxubh3WH7s9M
         njwsKXzCx2zfzcD5pbffewSKpGGg7K99MTHFKj9sgV5YaZnjCUhsTo2g8P5sdALrhSYv
         U8Dik3xc5nPijn/OeRpq9e4SZm8yzOPm2bK/atEahtvCy3xc5iFR1Qx8s4T7Rot04+hy
         fr7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1788834752; x=1789439552; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QQFakzH5ezRHmdy66K1wxZ0Prtbhmc8e0YvL+1cXyNI=;
        b=N2Tn5koyo+vLepiOqwzxwjHob3jJQxbMwJXBL8+vig9V44rY0cLCoSIwI9TnWKQg2e
         OMkYtf7bR0SBPcq9odYAx5iYek6SPxZUAGRr7srYuIyq642BYlVzcP7OqzJmlsHmpPs0
         P0wxcjo8KsN9R1JsmsPtIv17BGlGlG/dxCp+YRZBW/9nVR03bE6ZbWIfMUzoGpjgkGcA
         GQCMzkQSnYoi59M7W/gtND1G7TRp9baLdbJrCrtf2GjCpp37A4oliXkpkJR5AW6Qo9L0
         a423cjvWuOh1dyMEEZ5HwACEXEYWR/3P9FW0j3WqxE9uAllnW18L6HYlneLbE/c1d3Wy
         l++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788834752; x=1789439552;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QQFakzH5ezRHmdy66K1wxZ0Prtbhmc8e0YvL+1cXyNI=;
        b=dGw9bB4NqxGymGJV5xo//wbniPFxRsHysRyg8utmHVNELosHtwXma1grwXFhTX/JcI
         l1z1APYuHAhU8Vm/cs2R0dsv855UR/jFQOZJlo6JleLUW35I1wBOx0eylrpHg6hNw/5d
         qdTDZQypXDjypfXeOFSzsc1DI9hEvEAIiVxSRJBr+6w4JzDX9UqOO70eZWAZ9GEqbqE0
         LQBVitxGI+EnNFpHQvTt8eDt/e05QcR5Sp3D81qLBvgYEBJGFnivsN8pWjlVrtitKnXw
         LMCzbTGKCIbzCuf+zKMxNeCDyAIBeLV7zJuZkWROmSYNMwKKM4XZz9Gtcp5P14N//1mF
         Xelg==
X-Gm-Message-State: AFuF++kp+QH1A6ynmFD9mztsgrsn6Z30f5I+bTY5dX0HMLbofAtTi5lx
	xTOeHljXRDzXu4iMZlbXwaTv5sAlLgPx197LYF8nRTLsTF0/M6A3hmJ4e3a0n6O4HLoed67Ii2C
	4qmMCIYIlYorwAYJ6Myup7FkT1u+to1fdpu8MBG36
X-Gm-Gg: AYBFou3GPPUEMZRqGn1W1dHbVjEA26beYgBHi8o6ieRK9gKNJFwuaA96acjnuhitQZL
	0tJrRTTQbZ/22QNExQBJi8AFoyVTK7LHQeP7DWHsu2u1qilXMwvYLuBbKzRe7QdOWLfUxkKmbxo
	AvTojoIprEVDK6JgzmCrCmE+LQnx0mILAo7sy926Qv9vbGKWdX0RcCmMEEBFARgeCYJXYBfmUq8
	dnOdIwZU56/vfkSdcPwx8+cz3mlfH87AuOeSaRdvMHBuKbbeOxgRHavAY7+slyoxDPKAq+2nBh5
	fAuOnqrLkq9LpNalEcp2BqIbXyC3pWwcy4f+shSyb1+XMEv4D05BVFAgVbjc22jx7/ICeFO/eKu
	YATAaltcF45kd2keifnG8n84IEV/HSgo=
X-Received: by 2002:a17:903:3c24:b0:2db:479a:5127 with SMTP id
 d9443c01a7336-2db479a55c8mr167277835ad.19.1788834751616; Mon, 07 Sep 2026
 19:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903090053.13120-1-jack@suse.cz> <20260903090508.1360863-4-jack@suse.cz>
 <3b119174-7b10-6eb6-7aff-462949fcb49a@google.com>
In-Reply-To: <3b119174-7b10-6eb6-7aff-462949fcb49a@google.com>
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Mon, 7 Sep 2026 19:32:20 -0700
X-Gm-Features: AcwNN1WQDihV66cQ-OHH0AQpq0YHKUYC6t3qZ2Ny2_gI23ZREwXcpRRBLjG5-dg
Message-ID: <CA+0ovCgQaS0mAJPDz=qMQkRgMQ0Tco5PRFHPtQo+ForkqdgC3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] shmem: Refuse to enable tmpfs format for another filesystem
To: Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	ocfs2-devel@lists.linux.dev, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: multipart/mixed; boundary="000000000000ef6e9d065aef8b9a"

--000000000000ef6e9d065aef8b9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for the delay in response. Upon our run, the patched kernel
(this patch on 28924df2a08f) no longer panics on the attached
reproducer.

Thanks!


On Thu, Sep 3, 2026 at 8:15=E2=80=AFAM Hugh Dickins <hughd@google.com> wrot=
e:
>
> On Thu, 3 Sep 2026, Jan Kara wrote:
>
> > It is possible to issue Q_QUOTAON quotactl(2) e.g. for ext4 filesystem
> > requesting to enable quota using tmpfs quota format. With suitable
> > passed arguments this can actually succeed in enabling tmpfs quota
> > format on top of ext4 filesystem which leads to crashes later in
> > dquot_acquire().  As tmpfs quota format is intended for tmpfs
> > filesystems only, verify we are indeed enabling quotas there.
> >
> > Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> > Signed-off-by: Jan Kara <jack@suse.cz>
>
> Acked-by: Hugh Dickins <hughd@google.com>
>
> Thanks: yes, please do route it through your tree.
>
> > ---
> >  mm/shmem_quota.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
> > index d0b92d6da50f..a3fa4bd93e75 100644
> > --- a/mm/shmem_quota.c
> > +++ b/mm/shmem_quota.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/rbtree.h>
> >  #include <linux/shmem_fs.h>
> > +#include <linux/magic.h>
> >
> >  #include <linux/quotaops.h>
> >  #include <linux/quota.h>
> > @@ -54,6 +55,10 @@ struct quota_id {
> >
> >  static int shmem_check_quota_file(struct super_block *sb, int type)
> >  {
> > +     /* Verify enabling happens on tmpfs superblock */
> > +     if (sb->s_magic !=3D TMPFS_MAGIC)
> > +             return 0;
> > +
> >       /* There is no real quota file, nothing to do */
> >       return 1;
> >  }
> > --
> > 2.51.0

--000000000000ef6e9d065aef8b9a
Content-Type: text/x-c-code; charset="US-ASCII"; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mts1yf5c0>
X-Attachment-Id: f_mts1yf5c0

LyoKICogUmVwcm9kdWNlciBmb3IgMTAzLXF1b3RhLW51bGwtZnVuYy1wdHItZHF1b3RfYWNxdWly
ZQogKi8KI2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHN0
ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgojaW5jbHVk
ZSA8c3lzL21vdW50Lmg+CiNpbmNsdWRlIDxzeXMvcXVvdGEuaD4KI2luY2x1ZGUgPHN5cy9zdGF0
Lmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPGxpbnV4L2xvb3AuaD4KCiNkZWZpbmUg
UUZNVF9TSE1FTSA1CgppbnQgbWFpbih2b2lkKQp7CgljaGFyIGRldlszMl07CglpbnQgZmQsIGxm
ZCwgbjsKCglmZCA9IG9wZW4oIi90bXAvaSIsIE9fUkRXUiB8IE9fQ1JFQVQgfCBPX1RSVU5DLCAw
NjAwKTsKCWZ0cnVuY2F0ZShmZCwgNjQgPDwgMjApOwoJY2xvc2UoZmQpOwoJc3lzdGVtKCJta2Zz
LmV4dDQgLXFGIC1PIF5xdW90YSAvdG1wL2kiKTsKCglmZCA9IG9wZW4oIi9kZXYvbG9vcC1jb250
cm9sIiwgT19SRFdSKTsKCW4gPSBpb2N0bChmZCwgTE9PUF9DVExfR0VUX0ZSRUUpOwoJY2xvc2Uo
ZmQpOwoJc3ByaW50ZihkZXYsICIvZGV2L2xvb3AlZCIsIG4pOwoJbGZkID0gb3BlbihkZXYsIE9f
UkRXUik7CglmZCA9IG9wZW4oIi90bXAvaSIsIE9fUkRXUik7Cglpb2N0bChsZmQsIExPT1BfU0VU
X0ZELCBmZCk7CgljbG9zZShsZmQpOwkJLyogZXh0NCBtb3VudHMgdGhlIGJsb2NrZGV2IGV4Y2x1
c2l2ZWx5ICovCgljbG9zZShmZCk7CgoJbWtkaXIoIi9tbnQvcSIsIDA3NTUpOwoJbW91bnQoZGV2
LCAiL21udC9xIiwgImV4dDQiLCAwLCAidXNycXVvdGEiKTsKCgkvKiB0aGUgcXVvdGEgZmlsZTog
c2htZW1fY2hlY2tfcXVvdGFfZmlsZSgpIHdhdmVzIGFueSBmaWxlIHRocm91Z2ggKi8KCWNsb3Nl
KG9wZW4oIi9tbnQvcS9hcXVvdGEudXNlciIsIE9fUkRXUiB8IE9fQ1JFQVQsIDA2MDApKTsKCS8q
IGEgdmljdGltIGlub2RlIGhlbGQgb3BlbiBmb3Igd3JpdGU6IGFkZF9kcXVvdF9yZWYoKSBvbmx5
IHZpc2l0cwoJICogaW5vZGVzIHdpdGggYSBub24temVybyBpX3dyaXRlY291bnQgKi8KCW9wZW4o
Ii9tbnQvcS92aWN0aW0iLCBPX1JEV1IgfCBPX0NSRUFULCAwNjAwKTsKCglxdW90YWN0bChRQ01E
KFFfUVVPVEFPTiwgVVNSUVVPVEEpLCBkZXYsIFFGTVRfU0hNRU0sCgkJIChjYWRkcl90KSIvbW50
L3EvYXF1b3RhLnVzZXIiKTsKCXJldHVybiAwOwp9Cg==
--000000000000ef6e9d065aef8b9a--
