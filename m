Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795047182;
	b=kIgvIFf0IrcrWMiu40Lktc9qG8aB2QYKhVe1hKaGZo6w9KVL1tRL9dym6dOOmipDDdmQ
	 Zf7FE4K9ljKM6nzrvWFHwwfsl7YfU0if7zW0x2VwcUnmDuS1zgZe8BbvQxvdeuf/in7gw
	 YDz10xQPRkvzhmgUEIqlNGiq/ztMJ+dFJNyT01kRAoEu4wZ0mofUnL7s3mQYtZt1wmzhu
	 2a7fQ3r5WhYwpqGwBMb4kka5oOM4zEQP6o2oypozJN7Y8AaljgD9v6M24GpEL8Fowopz9
	 CqTbes1ywPvIrIBuTlvb2aPa+fnRIafh7z5qy3tzlYFStJQ0/q+GPCKds69GKBeryFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047182;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=077/TizvhH3iQcetqO0vvepvTnfIkqb5hqSDa7XFIt8=;
	b=ff1BjSVoXVmh1PfYQPeHF8PvtVBcL2dBjkH487NauCIpLov45FAEhE7WTl1Q3x0GWuQx
	 bSH2uGycpLFhiboWXVD6PrOto0DEQPX+1nZNuZMYvXg9ZhdZpYuRddwqAciatNPemt/er
	 6Cgji+QLaewoLNMYKu2rHa3ILh7UV/cV+DzfcwfOFfjpuiKXAuM1EhZ07sj81CGNN310d
	 isn5qlcGgRupxJgGhlpiKAAol+WZAjq5RFWyooCrKs9t2dJaIObBcgLAneGiaZ/v00yee
	 obyEK2bzNmL0t5xZXC6E9oDvz19lUgL+CRLD8He0pcdWTL+aiOfJy/6HHdLyBqeEm6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EjHXD+uH;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gUck6dLA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5C606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 00:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2E5C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EjHXD+uH;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gUck6dLA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795047179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=077/TizvhH3iQcetqO0vvepvTnfIkqb5hqSDa7XFIt8=;
	b=EjHXD+uHIPilX0rB0j3Mlz2PJl5Wi/+DfCXmEOtxmu6urupg9yBolQ8etjCxA4Lu+f1RJA
	UnPoNl/XtRiUArG2jVcKflDK+1Z5hzEF1Pduh5IDJ0BymRJwdm4ZSe2v12QFbs5YyQUVYg
	glzbZU2VWYP3jIPfmZOsVF1LyqqNm7E=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-aV-Cz43_P4aGsLXCRUUskA-1; Wed, 18 Nov 2026 19:12:58 -0500
X-MC-Unique: aV-Cz43_P4aGsLXCRUUskA-1
X-Mimecast-MFC-AGG-ID: aV-Cz43_P4aGsLXCRUUskA_1795047178
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6798fd97f3aso2725728d50.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:12:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795047178; cv=none;
        d=google.com; s=arc-20260327;
        b=pYTAb/rvfWOlAVSa0zXaZDJTAuM9OxKSfdLF2BpwvoRLRurPBa+vgxVm0DG2LbDDLr
         Sz8TmZZq+/LmvdtwhXpPiB/ADye0WiWbE7vVpW/i3/o96Boj+8LNZHVwQLUBh2PL8kLh
         QEALPnylZfo1aREQxXZjF8Zi4vZlkZnmGX+AldU3tffOYPRddqzXzfGP795U+WaZuZwJ
         Q9mYxQpFiTNCuXafDB39UD5YSxzCdOTK8/UJjbxFBncxn3h2j7Y2syn2vGGzeC/Xg84d
         aOyrA9nVPMmHTcAN/pNoyeBNa7wtEb9L7uiG43/iRV/vYBnA1RZa8wYuc+/jz1cAdeFE
         ccJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=077/TizvhH3iQcetqO0vvepvTnfIkqb5hqSDa7XFIt8=;
        fh=0YxkLu3nVuYUBifM1QFTPspj/o8zno0eH/90p7HGNbI=;
        b=rh5u/dTExbM0REF5pyGzVe0U0L8u5heT4GctNvEfO7Rr6tzA+mmB98nPPMZE0ig+/i
         LLZGR3n07nQGBTyx0eI3srd2hQSMzKei/e/EOrxTHqlqFU/FJuV2jZ5d6Ni27/ov2ObR
         LX7XjqPdKEOkewChNo12k6ZyLl4N+2f5C9SGWPHt/n+ZZNCTATVIsFLiVsXaboe3cevp
         H1WfEno0JKTy6l0US/AL/Uvl7UcO4ic0EQcaSQ9AZosE2nv+3Iw9GvWWvGzXcQpzU8cH
         vPCSPIG0uiXOLVT6wK0lo8CgWhv6fyUXqrygIAbsQpmlENAdX3Egg6+q+Hihi+ZR9HYN
         UCSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795047178; x=1795651978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=077/TizvhH3iQcetqO0vvepvTnfIkqb5hqSDa7XFIt8=;
        b=gUck6dLAwdhYR60Buifwx95UYkvNlKNRmPnyo7USrjas+FkHH6q0XlA8zMbJUAOSEc
         4esQdx6pFabYHTtqUnRAbnqHQA+DgcA1v9Z8q382bLMxM7p546hudO1FBCaRByt15IEm
         /5vyT5BVDmw2cAmmuJOGyhMjBm6Z38q8chTcv+ssHh/G49YDGn4gHaXvGAwNX+jSP5Bt
         Y6dNlXK3huhbk8odG0lKZoxQMQgtT0ra6l6EpuazzBV6saVVp3imwrgtOTJyno51uUmc
         6zZmOUm07V1gdA8XhQX9VKm6Mrqa2q5yZBP+0CYfzheFkQJZm4upXymWAt8SIYWCbdr8
         DWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047178; x=1795651978;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=077/TizvhH3iQcetqO0vvepvTnfIkqb5hqSDa7XFIt8=;
        b=MnwsOCEk+tamyWl8g0A41aTV9ASnQF8IuNf/7YfirJE3NHrTdt4H/P70EPHQsvZrbh
         ReVj0o2+WV5BBHe+SbxToLP32iOf9+eEzXkFkML+wPqBPWM8hjKOVSUKMwJF/vt2CCM4
         Qel48FVRDgtkPD/nYdNI8qd26Gla3qPYXmsRM79PQd34fbHbPo43OSZ9a35Ma78iSit2
         AX5EAqPCHqMrVzh6/Ge6mlrWbJfYz9gco3t7xYnyhZjJkUa0aIFe+24+CQf1uI3IB47X
         P7ZJ6JhabM4dOZGjCByVmCKTeHTcghFfOnB8IKQno2ENsI71RfuzPZ3khusZB4eOwac2
         CAyg==
X-Forwarded-Encrypted: i=1; AL+hErF55XV5qyNllIcMgnxVZJebTJdcvN8e7VMXM6gZtYDhu29PeJ3CSeiol3w0AB7ak4hZsGn7x1fZUGSfMl0K@vger.kernel.org
X-Gm-Message-State: APuU4Z/aTI0IA0/dRVdrUF9yx7aBunU04Lew85Dnb79XZiO0hMf4JTfl
	bAY2R2Yfm2IoMiFVFfoQXIkcLqe4riQ62jHZNckpF4/AW23iJGTbWbyic4NDWEF3IDHbfzn8nVd
	0WoATDmUxjdtyQPDPECCGzbHokGOgv38g57J6OmH0s0GcropG04skJWSIxzgLWQsR4G+JgJBgSU
	ihzSdSsqo9MfDWJoLa/WcdkOyGlK25vW2aj3jamCaWBw==
X-Gm-Gg: AZFdTZe4JKihG8Xlh+YMJsa/nc2nvN4BE9Oq1KwdqadDAh9qvkCPTqYEyOV3tSnFJUy
	EN6tqrUhxGvkEyclDwgtPseKLyDrTKwhyBmRpAWjpAhGb7nkxFVzf+R8jFzaGg6tUzlEmlzLmr4
	2NIdlbyQULUZcI210PB7T+BqxK/bSWQtJCBmYJRl8WJqsdB/kUR+h8HC0wh/P4iFZEx4dg+cvDL
	Dohf8vtd7wVRJ0yvHRhWSJcEhPmskPyJ35VdOzTMnwEZw==
X-Received: by 2002:a05:690e:1907:b0:67d:b34c:9f19 with SMTP id 956f58d0204a3-67dd3fdcc80mr1565900d50.106.1795047177729;
        Wed, 18 Nov 2026 16:12:57 -0800 (PST)
X-Received: by 2002:a05:690e:1907:b0:67d:b34c:9f19 with SMTP id
 956f58d0204a3-67dd3fdcc80mr1565894d50.106.1795047177150; Wed, 18 Nov 2026
 16:12:57 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116171044.6938-1-jack@suse.cz> <20261118145941.1063127-22-jack@suse.cz>
In-Reply-To: <20261118145941.1063127-22-jack@suse.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 19 Nov 2026 01:12:45 +0100
X-Gm-Features: AclHuK8R-2iEv0c9btS3snfH7Yzq75Yl9vf1mN1FPuSVCWTRM2Ut7aYcwFy-L9Y
Message-ID: <CAHc6FU4+FV=A2UK1oPejHSt5XQ2Ox+CyvZfT4Q17YaceJ+NJ1w@mail.gmail.com>
Subject: Re: [PATCH 09/13] gfs2: Fix dirtiness checks in gfs2_write_inode()
 and evict_linked_inode()
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, 
	Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	linux-afs@lists.infradead.org, Miklos Szeredi <miklos@szeredi.hu>, 
	fuse-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ja,


thanks for catching this.

On Wed, Nov 18, 2026 at 4:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> The checks are bogus because they check against inode->i_flags instead
> of inode->i_state. Use the inode_or_folios_dirty() helper which actually
> checks what was intended.
>
> Fixes: 957a7acd46e6 ("gfs2: Remove inode from ordered write list in gfs2_=
write_inode()")
> Fixes: bd67f17718cc ("gfs2: Fix data loss during inode evict")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/gfs2/super.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 04bb4cf787d4..9b723dd591a5 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -460,7 +460,7 @@ static int gfs2_write_inode(struct inode *inode, stru=
ct writeback_control *wbc)
>                 mark_inode_dirty_sync(inode);
>         else {
>                 spin_lock(&inode->i_lock);
> -               if (!(inode->i_flags & I_DIRTY))
> +               if (!inode_or_folios_dirty(inode))
>                         gfs2_ordered_del_inode(ip);
>                 spin_unlock(&inode->i_lock);
>         }
> @@ -1418,7 +1418,8 @@ static int evict_linked_inode(struct inode *inode, =
struct gfs2_holder *gh)
>         struct address_space *metamapping =3D gfs2_glock2aspace(gl);
>         int ret;
>
> -       if (!(test_bit(GLF_DIRTY, &gl->gl_flags) || inode->i_flags & I_DI=
RTY))
> +       if (!(test_bit(GLF_DIRTY, &gl->gl_flags) ||
> +             inode_or_folios_dirty(inode)))
>                 goto clean;
>
>         /* The inode glock must be held exclusively and be instantiated. =
*/
> --
> 2.53.0
>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Andreas

