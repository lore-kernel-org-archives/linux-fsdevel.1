Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED430E829
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161503; cv=pass; b=oIr0FF4zskq2PouiIprW12T9hgLiQK8hVJAi6sLFvEXZaTMQUri8+7Yid8fVk0uRG7gYSgjKwuiQ8sgkWt3zHzG2qgmnGI0lTtVynUk0cNHZjvSKdFY2I7heZTQ5w0gh7f0B73peP/lwiwa9hpCGen3LRMOY0UaJhvm4M8y/2wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161503; c=relaxed/simple;
	bh=jCKdYesyLQf2KYGr2+L6MkxpK0iZ88Ecko4A6v/cAu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0rNuRe5Djq7egwG0XMv7Li4Ei5pV0SjXHHUqI7shzEizqU2gg0vWWGp9tBqEm0KXnKAEtesam75c4v9K5S0BQZDwLlVFaZz5vQ2xAqa+XTWknM6H04/1u90xM1GWcREfJfz9ko62A0EiPK/AuXpBM1TwHgJO1gMsmlIApM861U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=L9IijMlZ; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="L9IijMlZ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7dd5a8dc8a2so13918917b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 10:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780161501; cv=none;
        d=google.com; s=arc-20240605;
        b=Bj+dyliqLluu1V+s0Yec0zxLjXsZEVlKgh7ICymijcipu2RogFTWBC3anylqLWF3xV
         ucHF6nJNMLBcEO/8Mu+EMeLkOI5ghgAwbwY1w1TT2IzyDiuQc9sd4QMPvKkfeGTv4np8
         ZqNl2UGC5xfCuVH0Fc8fik9qcECFCm/BFbYxhZr+2totgGy6LQYxWjmBx+BvUM/dIoSH
         OLvrhZ/CyJndEBzmuD8Szfr3/952g5TYOOvGrkwWA5g80W3CsX1VyJ8vKy5r7t3vsjel
         V3A+/OtrzDA5lAf5E7311oDG8fixT33q2P76x+hncyaa3xs7uZexrbGPzB0S+NXQayKx
         28rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ut5D8Hx7LXhZMx6Qn53Ify1pDXV1B3w1yVhqqNAkT70=;
        fh=4aIngFlcxAqgwu0wbg3+zLN+nnquhygM/8V2b0xqIyA=;
        b=ehJ2Se3EwmHPLeReEv7g1MZLTcey/cypxUpAvq2k7dWu+E/uXk3pbxmxqnVd1rt4RX
         fHYOQNHZotEqrciYfrvyln404SAKIYIaqDKWv0gnjLclhLxckxxbv+4i/5XcaQW17wwf
         /oGW/n+9TuwnmPWFusOyDXkEsspVa5hQMvvMJcI11NTtEF5cSr++KPSVcjpbEQ7nDxX2
         zMprA2lT3guVmwubxRY7Lvj1SIgmHGVcLJUzFtyGRiWt2XoRkJnsx37UqC4KtJbZBQc5
         L+E/dMJQEKMGwvqgH+pE+tUdH11alZ3Q893sB8+FwntxeBWICfc080sCze2BIjkv1dmt
         eGoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1780161501; x=1780766301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut5D8Hx7LXhZMx6Qn53Ify1pDXV1B3w1yVhqqNAkT70=;
        b=L9IijMlZkatbf5SIsx+x8MzOU//+J/m6B9XqYav2tSXKAQ6jKieHRA5i0DDfZvA1zG
         FYLlpT4nZ0sydvMv6dVK8WNoBXm+QKaMf/XduHJPu+YwHg0GNGgVzBqjdB8R3gz0zjY/
         9m1n4VAZo6ig+bJfoE03votCh0q57Rnnen8P/WE6J2BY+ot0BP0WNDVjhWsMV+Rhp3ou
         bu6As2rD2U212+8Gajsn9ubIn1uCLBGiSsyQCnYk6DhyJikCNPVn5wXNS87D8YwE3dDv
         m+dWH7/VUvL6GYT6Y8NVj1QYsZG/Q1iKnNim44qbo04iUMqy7rI4D7w+9Uv7ePPo1qfW
         pkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780161501; x=1780766301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ut5D8Hx7LXhZMx6Qn53Ify1pDXV1B3w1yVhqqNAkT70=;
        b=Ly9oWgqSHoDRfOAApVaDvQ8Qbe7O/1ZIU2aKNADu5/S9BHg70rB2LJWfRUiPfompSl
         Vhs/MwY9yFi5FvV/zeWvkHjEvTcKYSMNFX3mdmLig27xA9iQLy6zMZtk8b6ONpS1xKiY
         tFDvfrNwsS1AjCP4MXGvzK7pOVAti8aPf75PWPDU9nrgBwjmRrn2Kpcuqm6d2gQQ/1Bo
         HeP3cMRZ+7yqhhoAgMzBJXBQOmDa1b360fQqTBUUkXqdz6jHQa6xT0muiA5Ts0fMRP7M
         zOxcHF34rIdUGJYBB1v+E4fonTlGGhuuEtaC+vWLr0wfHXjSQ5kioUmETw6hHeuMcWiR
         SfAw==
X-Forwarded-Encrypted: i=1; AFNElJ92Fvpauy+UEqovs7ifEe/gdzA9SWER21CBVLgcbwGahtuXIgH9oATZMW0gTLczzVoa9Z5qCCS6x2gXRCIH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjq2yiA32Dl+wxxNG4QS8nbTQxcvIcB3m+wKEr3zQU+72o9fyG
	HIDRe2RRE//1iyUfrY4OKgCNe5gTOmQGXwHKmTYLhEOt2+RPBVJ1cL4BwnFdVbd7DGFGrbSNnp1
	fANqJKLokCqQepix45EmZEWjrkApsfieKkVUhMuCi
X-Gm-Gg: Acq92OHsj1PDI+Ewob7LrV/KYqqFh3eX66YYWBRCNqbmwAjPDp4SJ+U3O0Fo+xcujE+
	4oQe6lqtNJhfYBZ0N+WXtN8e0wgKdSocu9kL9ol43TJD0MHQhAcK7BCzmBzcymKBs1Q83HV0aFA
	fLtKza7fU5pR8LqELOfNyrGnIoBFeWxWK+PXRb/nF5KlWse7EHeRJavdR8v8nOcC40BwTS0gFDh
	lVVgAatw+iXnpKwK4qJ69vk5HMGIrAbK7NEFNlM6Qc3ZwCiuqAOykYGZbpL0d53UmPRuq99QjB1
	MpsWzU8JSHX9s/eTYw==
X-Received: by 2002:a05:690c:6311:b0:7dd:7abb:2f2 with SMTP id
 00721157ae682-7e05a574494mr40562907b3.1.1780161499861; Sat, 30 May 2026
 10:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovCjv-VYvn-4jUj3wDn+DuP9FSv-GL+yPAHbR=ZGKU0wmGg@mail.gmail.com>
 <ahbG94EFLD5ntnYr@gmail.com>
In-Reply-To: <ahbG94EFLD5ntnYr@gmail.com>
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Sat, 30 May 2026 10:18:08 -0700
X-Gm-Features: AVHnY4LMHr6JxNFWhybc2laI3XRS5tSTbIC_ggDNbfXkaUiNgEneHmHuanNq6_M
Message-ID: <CA+0ovCj_feDKzpFjctbRLFeuRf4iHHaqBt7ay_U7GRinygmi-Q@mail.gmail.com>
Subject: Re: [BUG] configfs: slab-use-after-free in configfs_drop_dentry() on rmdir
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d885fe06530c25bc"

--000000000000d885fe06530c25bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Breno,

Thanks for sending the patch. I applied your patch on top of v7.1-rc5
e7ae89a0c97ce2b68b0983cd01eda67cf373517d and rebuilt with the same
config that originally caught this. The attached reproducer now runs
without causing a panic. Without the patch, the same reproducer still
trips it.

Please feel free to add:
    Tested-by: Farhad Alemi <farhad.alemi@berkeley.edu>

Thanks again,

On Wed, May 27, 2026 at 3:27=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Tue, May 26, 2026 at 08:42:00PM +0000, Farhad Alemi wrote:
> > Hello Andreas and the configfs team,
> >
> > I am reporting a configfs use-after-free found by syzkaller.
> >
> > Summary:
> > A configfs config-item rmdir(2) can land in configfs_drop_dentry() with
> > sd->s_dentry pointing at a dentry whose RCU grace period has not yet
> > elapsed. The spin_lock(&dentry->d_lock) at fs/configfs/inode.c:209 then
> > reads freed slab memory and KASAN reports a slab-use-after-free.
>
> Thanks for the report. I was able to reproduce it on linus' upstream
> tree.
>
> I've came up with the following fix, would you mind trying it, please?
>
>
> commit d78c04736ef0ede76093c780a188560b6baed3c3
> Author: Breno Leitao <leitao@debian.org>
> Date:   Wed May 27 06:25:49 2026 -0400
>
>     configfs: fix UAF in configfs_drop_dentry() after failed attribute lo=
okup
>
>     When configfs_lookup() matches an attribute it publishes the new dent=
ry
>     into sd->s_dentry (and dentry->d_fsdata) before calling
>     configfs_create() to allocate the inode:
>
>             dentry->d_fsdata =3D configfs_get(sd);
>             sd->s_dentry =3D dentry;
>             spin_unlock(&configfs_dirent_lock);
>
>             inode =3D configfs_create(dentry, mode);
>             if (IS_ERR(inode)) {
>                     configfs_put(sd);
>                     return ERR_CAST(inode);
>             }
>
>     If configfs_create() fails (e.g. new_inode() returns NULL under memor=
y
>     pressure or fault injection), the lookup returns an error and the
>     caller dputs the now-negative dentry, which goes through
>     __dentry_kill() and is freed via call_rcu().
>
>     Because the dentry never gained an inode it does not go through the
>     .d_iput op (configfs_d_iput), which is the only place that clears
>     sd->s_dentry.  sd therefore keeps a stale pointer to the freed dentry=
.
>     A subsequent rmdir of the parent item walks the parent's s_children
>     list in detach_attrs() and configfs_drop_dentry() does
>     spin_lock(&sd->s_dentry->d_lock) on freed memory:
>
>       BUG: KASAN: slab-use-after-free in _raw_spin_lock+0xac/0x110
>       Read of size 1 at addr ffff00012bacd028 by task repro/2440
>        _raw_spin_lock+0xac/0x110
>        configfs_drop_dentry+0x48/0x158 [configfs]
>        detach_attrs.isra.0+0x18c/0x494 [configfs]
>        configfs_rmdir+0x450/0x71c [configfs]
>        vfs_rmdir+0x170/0x620
>        ...
>       Freed by task 0:
>        __d_free+0x28/0x34
>        rcu_do_batch+0x37c/0x1bd0
>        ...
>       Last potentially related work creation:
>        call_rcu+0x34/0x68
>        dentry_free+0xe8/0x3e0
>        __dentry_kill+0x404/0x604
>        dput+0x14/0x30
>        lookup_open.isra.0+0x6ac/0xc00
>        path_openat+0xd18/0x2588
>
>     Fix this by tearing down the sd<->dentry linkage in the
>     configfs_create() error path, under configfs_dirent_lock, mirroring
>     what configfs_d_iput() would have done for a positive dentry.
>
>     Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
>     Signed-off-by: Breno Leitao <leitao@debian.org>
>
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 362b6ff9b908..68d857dcb2d9 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -486,6 +486,22 @@ static struct dentry * configfs_lookup(struct inode =
*dir,
>
>                         inode =3D configfs_create(dentry, mode);
>                         if (IS_ERR(inode)) {
> +                               /*
> +                                * configfs_create() failed (e.g. -ENOMEM
> +                                * from new_inode()).  The dentry will be
> +                                * dput()ed by the caller and freed via R=
CU;
> +                                * because it never gained an inode,
> +                                * configfs_d_iput() will not run to clea=
r
> +                                * sd->s_dentry.  Drop the linkage here s=
o a
> +                                * later detach_attrs() walking the paren=
t's
> +                                * s_children list does not dereference a
> +                                * freed dentry in configfs_drop_dentry()=
.
> +                                */
> +                               spin_lock(&configfs_dirent_lock);
> +                               if (sd->s_dentry =3D=3D dentry)
> +                                       sd->s_dentry =3D NULL;
> +                               dentry->d_fsdata =3D NULL;
> +                               spin_unlock(&configfs_dirent_lock);
>                                 configfs_put(sd);
>                                 return ERR_CAST(inode);
>                         }

--000000000000d885fe06530c25bc
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mpsm4wg90>
X-Attachment-Id: f_mpsm4wg90

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGRpcmVudC5oPgojaW5j
bHVkZSA8ZW5kaWFuLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2lu
Y2x1ZGUgPHNjaGVkLmg+CiNpbmNsdWRlIDxzZXRqbXAuaD4KI2luY2x1ZGUgPHNpZ25hbC5oPgoj
aW5jbHVkZSA8c3RkYXJnLmg+CiNpbmNsdWRlIDxzdGRib29sLmg+CiNpbmNsdWRlIDxzdGRpbnQu
aD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmlu
Zy5oPgojaW5jbHVkZSA8c3lzL2lvY3RsLmg+CiNpbmNsdWRlIDxzeXMvbW91bnQuaD4KI2luY2x1
ZGUgPHN5cy9wcmN0bC5oPgojaW5jbHVkZSA8c3lzL3Jlc291cmNlLmg+CiNpbmNsdWRlIDxzeXMv
c3RhdC5oPgojaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KI2luY2x1ZGUgPHN5cy90aW1lLmg+CiNp
bmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRlIDx0aW1l
Lmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCiNpbmNsdWRlIDxsaW51eC9jYXBhYmlsaXR5Lmg+Cgpz
dGF0aWMgX190aHJlYWQgaW50IGNsb25lX29uZ29pbmc7CnN0YXRpYyBfX3RocmVhZCBpbnQgc2tp
cF9zZWd2OwpzdGF0aWMgX190aHJlYWQgam1wX2J1ZiBzZWd2X2VudjsKCnN0YXRpYyB2b2lkIHNl
Z3ZfaGFuZGxlcihpbnQgc2lnLCBzaWdpbmZvX3QqIGluZm8sIHZvaWQqIGN0eCkKewogIGlmIChf
X2F0b21pY19sb2FkX24oJmNsb25lX29uZ29pbmcsIF9fQVRPTUlDX1JFTEFYRUQpICE9IDApIHsK
ICAgIGV4aXQoc2lnKTsKICB9CiAgdWludHB0cl90IGFkZHIgPSAodWludHB0cl90KWluZm8tPnNp
X2FkZHI7CiAgY29uc3QgdWludHB0cl90IHByb2dfc3RhcnQgPSAxIDw8IDIwOwogIGNvbnN0IHVp
bnRwdHJfdCBwcm9nX2VuZCA9IDEwMCA8PCAyMDsKICBpbnQgc2tpcCA9IF9fYXRvbWljX2xvYWRf
bigmc2tpcF9zZWd2LCBfX0FUT01JQ19SRUxBWEVEKSAhPSAwOwogIGludCB2YWxpZCA9IGFkZHIg
PCBwcm9nX3N0YXJ0IHx8IGFkZHIgPiBwcm9nX2VuZDsKICBpZiAoc2tpcCAmJiB2YWxpZCkgewog
ICAgX2xvbmdqbXAoc2Vndl9lbnYsIDEpOwogIH0KICBleGl0KHNpZyk7Cn0KCnN0YXRpYyB2b2lk
IGluc3RhbGxfc2Vndl9oYW5kbGVyKHZvaWQpCnsKICBzdHJ1Y3Qgc2lnYWN0aW9uIHNhOwogIG1l
bXNldCgmc2EsIDAsIHNpemVvZihzYSkpOwogIHNhLnNhX2hhbmRsZXIgPSBTSUdfSUdOOwogIHN5
c2NhbGwoU1lTX3J0X3NpZ2FjdGlvbiwgMHgyMCwgJnNhLCBOVUxMLCA4KTsKICBzeXNjYWxsKFNZ
U19ydF9zaWdhY3Rpb24sIDB4MjEsICZzYSwgTlVMTCwgOCk7CiAgbWVtc2V0KCZzYSwgMCwgc2l6
ZW9mKHNhKSk7CiAgc2Euc2Ffc2lnYWN0aW9uID0gc2Vndl9oYW5kbGVyOwogIHNhLnNhX2ZsYWdz
ID0gU0FfTk9ERUZFUiB8IFNBX1NJR0lORk87CiAgc2lnYWN0aW9uKFNJR1NFR1YsICZzYSwgTlVM
TCk7CiAgc2lnYWN0aW9uKFNJR0JVUywgJnNhLCBOVUxMKTsKfQoKI2RlZmluZSBOT05GQUlMSU5H
KC4uLikgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwKICAoeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgIGludCBvayA9IDE7ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAg
IF9fYXRvbWljX2ZldGNoX2FkZCgmc2tpcF9zZWd2LCAxLCBfX0FUT01JQ19TRVFfQ1NUKTsgICAg
ICAgICAgICAgICAgICAgICAgIFwKICAgIGlmIChfc2V0am1wKHNlZ3ZfZW52KSA9PSAwKSB7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgX19WQV9B
UkdTX187ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKICAgIH0gZWxzZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgb2sgPSAwOyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwKICAgIF9fYXRvbWljX2ZldGNoX3N1Yigmc2tpcF9zZWd2LCAxLCBfX0FUT01JQ19TRVFfQ1NU
KTsgICAgICAgICAgICAgICAgICAgICAgIFwKICAgIG9rOyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICB9KQoK
c3RhdGljIHZvaWQgc2xlZXBfbXModWludDY0X3QgbXMpCnsKICB1c2xlZXAobXMgKiAxMDAwKTsK
fQoKc3RhdGljIHVpbnQ2NF90IGN1cnJlbnRfdGltZV9tcyh2b2lkKQp7CiAgc3RydWN0IHRpbWVz
cGVjIHRzOwogIGlmIChjbG9ja19nZXR0aW1lKENMT0NLX01PTk9UT05JQywgJnRzKSkKICAgIGV4
aXQoMSk7CiAgcmV0dXJuICh1aW50NjRfdCl0cy50dl9zZWMgKiAxMDAwICsgKHVpbnQ2NF90KXRz
LnR2X25zZWMgLyAxMDAwMDAwOwp9CgpzdGF0aWMgdm9pZCB1c2VfdGVtcG9yYXJ5X2Rpcih2b2lk
KQp7CiAgY2hhciB0bXBkaXJfdGVtcGxhdGVbXSA9ICIuL3N5emthbGxlci5YWFhYWFgiOwogIGNo
YXIqIHRtcGRpciA9IG1rZHRlbXAodG1wZGlyX3RlbXBsYXRlKTsKICBpZiAoIXRtcGRpcikKICAg
IGV4aXQoMSk7CiAgaWYgKGNobW9kKHRtcGRpciwgMDc3NykpCiAgICBleGl0KDEpOwogIGlmIChj
aGRpcih0bXBkaXIpKQogICAgZXhpdCgxKTsKfQoKc3RhdGljIGJvb2wgd3JpdGVfZmlsZShjb25z
dCBjaGFyKiBmaWxlLCBjb25zdCBjaGFyKiB3aGF0LCAuLi4pCnsKICBjaGFyIGJ1ZlsxMDI0XTsK
ICB2YV9saXN0IGFyZ3M7CiAgdmFfc3RhcnQoYXJncywgd2hhdCk7CiAgdnNucHJpbnRmKGJ1Ziwg
c2l6ZW9mKGJ1ZiksIHdoYXQsIGFyZ3MpOwogIHZhX2VuZChhcmdzKTsKICBidWZbc2l6ZW9mKGJ1
ZikgLSAxXSA9IDA7CiAgaW50IGxlbiA9IHN0cmxlbihidWYpOwogIGludCBmZCA9IG9wZW4oZmls
ZSwgT19XUk9OTFkgfCBPX0NMT0VYRUMpOwogIGlmIChmZCA9PSAtMSkKICAgIHJldHVybiBmYWxz
ZTsKICBpZiAod3JpdGUoZmQsIGJ1ZiwgbGVuKSAhPSBsZW4pIHsKICAgIGludCBlcnIgPSBlcnJu
bzsKICAgIGNsb3NlKGZkKTsKICAgIGVycm5vID0gZXJyOwogICAgcmV0dXJuIGZhbHNlOwogIH0K
ICBjbG9zZShmZCk7CiAgcmV0dXJuIHRydWU7Cn0KCnN0YXRpYyB2b2lkIHNldHVwX2dhZGdldGZz
KCk7CnN0YXRpYyB2b2lkIHNldHVwX2JpbmRlcmZzKCk7CnN0YXRpYyB2b2lkIHNldHVwX2Z1c2Vj
dGwoKTsKc3RhdGljIHZvaWQgc2FuZGJveF9jb21tb25fbW91bnRfdG1wZnModm9pZCkKewogIHdy
aXRlX2ZpbGUoIi9wcm9jL3N5cy9mcy9tb3VudC1tYXgiLCAiMTAwMDAwIik7CiAgaWYgKG1rZGly
KCIuL3N5ei10bXAiLCAwNzc3KSkKICAgIGV4aXQoMSk7CiAgaWYgKG1vdW50KCIiLCAiLi9zeXot
dG1wIiwgInRtcGZzIiwgMCwgTlVMTCkpCiAgICBleGl0KDEpOwogIGlmIChta2RpcigiLi9zeXot
dG1wL25ld3Jvb3QiLCAwNzc3KSkKICAgIGV4aXQoMSk7CiAgaWYgKG1rZGlyKCIuL3N5ei10bXAv
bmV3cm9vdC9kZXYiLCAwNzAwKSkKICAgIGV4aXQoMSk7CiAgdW5zaWduZWQgYmluZF9tb3VudF9m
bGFncyA9IE1TX0JJTkQgfCBNU19SRUMgfCBNU19QUklWQVRFOwogIGlmIChtb3VudCgiL2RldiIs
ICIuL3N5ei10bXAvbmV3cm9vdC9kZXYiLCBOVUxMLCBiaW5kX21vdW50X2ZsYWdzLCBOVUxMKSkK
ICAgIGV4aXQoMSk7CiAgaWYgKG1rZGlyKCIuL3N5ei10bXAvbmV3cm9vdC9wcm9jIiwgMDcwMCkp
CiAgICBleGl0KDEpOwogIGlmIChtb3VudCgic3l6LXByb2MiLCAiLi9zeXotdG1wL25ld3Jvb3Qv
cHJvYyIsICJwcm9jIiwgMCwgTlVMTCkpCiAgICBleGl0KDEpOwogIGlmIChta2RpcigiLi9zeXot
dG1wL25ld3Jvb3Qvc2VsaW51eCIsIDA3MDApKQogICAgZXhpdCgxKTsKICBjb25zdCBjaGFyKiBz
ZWxpbnV4X3BhdGggPSAiLi9zeXotdG1wL25ld3Jvb3Qvc2VsaW51eCI7CiAgaWYgKG1vdW50KCIv
c2VsaW51eCIsIHNlbGludXhfcGF0aCwgTlVMTCwgYmluZF9tb3VudF9mbGFncywgTlVMTCkpIHsK
ICAgIGlmIChlcnJubyAhPSBFTk9FTlQpCiAgICAgIGV4aXQoMSk7CiAgICBpZiAobW91bnQoIi9z
eXMvZnMvc2VsaW51eCIsIHNlbGludXhfcGF0aCwgTlVMTCwgYmluZF9tb3VudF9mbGFncywgTlVM
TCkgJiYKICAgICAgICBlcnJubyAhPSBFTk9FTlQpCiAgICAgIGV4aXQoMSk7CiAgfQogIGlmICht
a2RpcigiLi9zeXotdG1wL25ld3Jvb3Qvc3lzIiwgMDcwMCkpCiAgICBleGl0KDEpOwogIGlmICht
b3VudCgiL3N5cyIsICIuL3N5ei10bXAvbmV3cm9vdC9zeXMiLCAwLCBiaW5kX21vdW50X2ZsYWdz
LCBOVUxMKSkKICAgIGV4aXQoMSk7CiAgaWYgKG1vdW50KCIvc3lzL2tlcm5lbC9kZWJ1ZyIsICIu
L3N5ei10bXAvbmV3cm9vdC9zeXMva2VybmVsL2RlYnVnIiwgTlVMTCwKICAgICAgICAgICAgYmlu
ZF9tb3VudF9mbGFncywgTlVMTCkgJiYKICAgICAgZXJybm8gIT0gRU5PRU5UKQogICAgZXhpdCgx
KTsKICBpZiAobW91bnQoIi9zeXMvZnMvc21hY2tmcyIsICIuL3N5ei10bXAvbmV3cm9vdC9zeXMv
ZnMvc21hY2tmcyIsIE5VTEwsCiAgICAgICAgICAgIGJpbmRfbW91bnRfZmxhZ3MsIE5VTEwpICYm
CiAgICAgIGVycm5vICE9IEVOT0VOVCkKICAgIGV4aXQoMSk7CiAgaWYgKG1vdW50KCIvcHJvYy9z
eXMvZnMvYmluZm10X21pc2MiLAogICAgICAgICAgICAiLi9zeXotdG1wL25ld3Jvb3QvcHJvYy9z
eXMvZnMvYmluZm10X21pc2MiLCBOVUxMLCBiaW5kX21vdW50X2ZsYWdzLAogICAgICAgICAgICBO
VUxMKSAmJgogICAgICBlcnJubyAhPSBFTk9FTlQpCiAgICBleGl0KDEpOwogIGlmIChta2Rpcigi
Li9zeXotdG1wL25ld3Jvb3Qvc3l6LWlucHV0cyIsIDA3MDApKQogICAgZXhpdCgxKTsKICBpZiAo
bW91bnQoIi9zeXotaW5wdXRzIiwgIi4vc3l6LXRtcC9uZXdyb290L3N5ei1pbnB1dHMiLCBOVUxM
LAogICAgICAgICAgICBiaW5kX21vdW50X2ZsYWdzIHwgTVNfUkRPTkxZLCBOVUxMKSAmJgogICAg
ICBlcnJubyAhPSBFTk9FTlQpCiAgICBleGl0KDEpOwogIGlmIChta2RpcigiLi9zeXotdG1wL3Bp
dm90IiwgMDc3NykpCiAgICBleGl0KDEpOwogIGlmIChzeXNjYWxsKFNZU19waXZvdF9yb290LCAi
Li9zeXotdG1wIiwgIi4vc3l6LXRtcC9waXZvdCIpKSB7CiAgICBpZiAoY2hkaXIoIi4vc3l6LXRt
cCIpKQogICAgICBleGl0KDEpOwogIH0gZWxzZSB7CiAgICBpZiAoY2hkaXIoIi8iKSkKICAgICAg
ZXhpdCgxKTsKICAgIGlmICh1bW91bnQyKCIuL3Bpdm90IiwgTU5UX0RFVEFDSCkpCiAgICAgIGV4
aXQoMSk7CiAgfQogIGlmIChjaHJvb3QoIi4vbmV3cm9vdCIpKQogICAgZXhpdCgxKTsKICBpZiAo
Y2hkaXIoIi8iKSkKICAgIGV4aXQoMSk7CiAgc2V0dXBfZ2FkZ2V0ZnMoKTsKICBzZXR1cF9iaW5k
ZXJmcygpOwogIHNldHVwX2Z1c2VjdGwoKTsKfQoKc3RhdGljIHZvaWQgc2V0dXBfZ2FkZ2V0ZnMo
KQp7CiAgaWYgKG1rZGlyKCIvZGV2L2dhZGdldGZzIiwgMDc3NykpIHsKICB9CiAgaWYgKG1vdW50
KCJnYWRnZXRmcyIsICIvZGV2L2dhZGdldGZzIiwgImdhZGdldGZzIiwgMCwgTlVMTCkpIHsKICB9
Cn0KCnN0YXRpYyB2b2lkIHNldHVwX2Z1c2VjdGwoKQp7CiAgaWYgKG1vdW50KDAsICIvc3lzL2Zz
L2Z1c2UvY29ubmVjdGlvbnMiLCAiZnVzZWN0bCIsIDAsIDApKSB7CiAgfQp9CgpzdGF0aWMgdm9p
ZCBzZXR1cF9iaW5kZXJmcygpCnsKICBpZiAobWtkaXIoIi9kZXYvYmluZGVyZnMiLCAwNzc3KSkg
ewogIH0KICBpZiAobW91bnQoImJpbmRlciIsICIvZGV2L2JpbmRlcmZzIiwgImJpbmRlciIsIDAs
IE5VTEwpKSB7CiAgfQp9CgpzdGF0aWMgdm9pZCBsb29wKCk7CgpzdGF0aWMgdm9pZCBzYW5kYm94
X2NvbW1vbigpCnsKICBwcmN0bChQUl9TRVRfUERFQVRIU0lHLCBTSUdLSUxMLCAwLCAwLCAwKTsK
ICBpZiAoZ2V0cHBpZCgpID09IDEpCiAgICBleGl0KDEpOwogIHN0cnVjdCBybGltaXQgcmxpbTsK
ICBybGltLnJsaW1fY3VyID0gcmxpbS5ybGltX21heCA9ICgyMDAgPDwgMjApOwogIHNldHJsaW1p
dChSTElNSVRfQVMsICZybGltKTsKICBybGltLnJsaW1fY3VyID0gcmxpbS5ybGltX21heCA9IDMy
IDw8IDIwOwogIHNldHJsaW1pdChSTElNSVRfTUVNTE9DSywgJnJsaW0pOwogIHJsaW0ucmxpbV9j
dXIgPSBybGltLnJsaW1fbWF4ID0gMTM2IDw8IDIwOwogIHNldHJsaW1pdChSTElNSVRfRlNJWkUs
ICZybGltKTsKICBybGltLnJsaW1fY3VyID0gcmxpbS5ybGltX21heCA9IDEgPDwgMjA7CiAgc2V0
cmxpbWl0KFJMSU1JVF9TVEFDSywgJnJsaW0pOwogIHJsaW0ucmxpbV9jdXIgPSBybGltLnJsaW1f
bWF4ID0gMTI4IDw8IDIwOwogIHNldHJsaW1pdChSTElNSVRfQ09SRSwgJnJsaW0pOwogIHJsaW0u
cmxpbV9jdXIgPSBybGltLnJsaW1fbWF4ID0gMjU2OwogIHNldHJsaW1pdChSTElNSVRfTk9GSUxF
LCAmcmxpbSk7CiAgaWYgKHVuc2hhcmUoQ0xPTkVfTkVXTlMpKSB7CiAgfQogIGlmIChtb3VudChO
VUxMLCAiLyIsIE5VTEwsIE1TX1JFQyB8IE1TX1BSSVZBVEUsIE5VTEwpKSB7CiAgfQogIGlmICh1
bnNoYXJlKENMT05FX05FV0lQQykpIHsKICB9CiAgaWYgKHVuc2hhcmUoMHgwMjAwMDAwMCkpIHsK
ICB9CiAgaWYgKHVuc2hhcmUoQ0xPTkVfTkVXVVRTKSkgewogIH0KICBpZiAodW5zaGFyZShDTE9O
RV9TWVNWU0VNKSkgewogIH0KICB0eXBlZGVmIHN0cnVjdCB7CiAgICBjb25zdCBjaGFyKiBuYW1l
OwogICAgY29uc3QgY2hhciogdmFsdWU7CiAgfSBzeXNjdGxfdDsKICBzdGF0aWMgY29uc3Qgc3lz
Y3RsX3Qgc3lzY3Rsc1tdID0gewogICAgICB7Ii9wcm9jL3N5cy9rZXJuZWwvc2htbWF4IiwgIjE2
Nzc3MjE2In0sCiAgICAgIHsiL3Byb2Mvc3lzL2tlcm5lbC9zaG1hbGwiLCAiNTM2ODcwOTEyIn0s
CiAgICAgIHsiL3Byb2Mvc3lzL2tlcm5lbC9zaG1tbmkiLCAiMTAyNCJ9LAogICAgICB7Ii9wcm9j
L3N5cy9rZXJuZWwvbXNnbWF4IiwgIjgxOTIifSwKICAgICAgeyIvcHJvYy9zeXMva2VybmVsL21z
Z21uaSIsICIxMDI0In0sCiAgICAgIHsiL3Byb2Mvc3lzL2tlcm5lbC9tc2dtbmIiLCAiMTAyNCJ9
LAogICAgICB7Ii9wcm9jL3N5cy9rZXJuZWwvc2VtIiwgIjEwMjQgMTA0ODU3NiA1MDAgMTAyNCJ9
LAogIH07CiAgdW5zaWduZWQgaTsKICBmb3IgKGkgPSAwOyBpIDwgc2l6ZW9mKHN5c2N0bHMpIC8g
c2l6ZW9mKHN5c2N0bHNbMF0pOyBpKyspCiAgICB3cml0ZV9maWxlKHN5c2N0bHNbaV0ubmFtZSwg
c3lzY3Rsc1tpXS52YWx1ZSk7Cn0KCnN0YXRpYyBpbnQgd2FpdF9mb3JfbG9vcChpbnQgcGlkKQp7
CiAgaWYgKHBpZCA8IDApCiAgICBleGl0KDEpOwogIGludCBzdGF0dXMgPSAwOwogIHdoaWxlICh3
YWl0cGlkKC0xLCAmc3RhdHVzLCBfX1dBTEwpICE9IHBpZCkgewogIH0KICByZXR1cm4gV0VYSVRT
VEFUVVMoc3RhdHVzKTsKfQoKc3RhdGljIHZvaWQgZHJvcF9jYXBzKHZvaWQpCnsKICBzdHJ1Y3Qg
X191c2VyX2NhcF9oZWFkZXJfc3RydWN0IGNhcF9oZHIgPSB7fTsKICBzdHJ1Y3QgX191c2VyX2Nh
cF9kYXRhX3N0cnVjdCBjYXBfZGF0YVsyXSA9IHt9OwogIGNhcF9oZHIudmVyc2lvbiA9IF9MSU5V
WF9DQVBBQklMSVRZX1ZFUlNJT05fMzsKICBjYXBfaGRyLnBpZCA9IGdldHBpZCgpOwogIGlmIChz
eXNjYWxsKFNZU19jYXBnZXQsICZjYXBfaGRyLCAmY2FwX2RhdGEpKQogICAgZXhpdCgxKTsKICBj
b25zdCBpbnQgZHJvcCA9ICgxIDw8IENBUF9TWVNfUFRSQUNFKSB8ICgxIDw8IENBUF9TWVNfTklD
RSk7CiAgY2FwX2RhdGFbMF0uZWZmZWN0aXZlICY9IH5kcm9wOwogIGNhcF9kYXRhWzBdLnBlcm1p
dHRlZCAmPSB+ZHJvcDsKICBjYXBfZGF0YVswXS5pbmhlcml0YWJsZSAmPSB+ZHJvcDsKICBpZiAo
c3lzY2FsbChTWVNfY2Fwc2V0LCAmY2FwX2hkciwgJmNhcF9kYXRhKSkKICAgIGV4aXQoMSk7Cn0K
CnN0YXRpYyBpbnQgZG9fc2FuZGJveF9ub25lKHZvaWQpCnsKICBpZiAodW5zaGFyZShDTE9ORV9O
RVdQSUQpKSB7CiAgfQogIGludCBwaWQgPSBmb3JrKCk7CiAgaWYgKHBpZCAhPSAwKQogICAgcmV0
dXJuIHdhaXRfZm9yX2xvb3AocGlkKTsKICBzYW5kYm94X2NvbW1vbigpOwogIGRyb3BfY2Fwcygp
OwogIGlmICh1bnNoYXJlKENMT05FX05FV05FVCkpIHsKICB9CiAgd3JpdGVfZmlsZSgiL3Byb2Mv
c3lzL25ldC9pcHY0L3BpbmdfZ3JvdXBfcmFuZ2UiLCAiMCA2NTUzNSIpOwogIHNhbmRib3hfY29t
bW9uX21vdW50X3RtcGZzKCk7CiAgbG9vcCgpOwogIGV4aXQoMSk7Cn0KCiNkZWZpbmUgRlNfSU9D
X1NFVEZMQUdTIF9JT1coJ2YnLCAyLCBsb25nKQpzdGF0aWMgdm9pZCByZW1vdmVfZGlyKGNvbnN0
IGNoYXIqIGRpcikKewogIGludCBpdGVyID0gMDsKICBESVIqIGRwID0gMDsKICBjb25zdCBpbnQg
dW1vdW50X2ZsYWdzID0gTU5UX0ZPUkNFIHwgVU1PVU5UX05PRk9MTE9XOwoKcmV0cnk6CiAgd2hp
bGUgKHVtb3VudDIoZGlyLCB1bW91bnRfZmxhZ3MpID09IDApIHsKICB9CiAgZHAgPSBvcGVuZGly
KGRpcik7CiAgaWYgKGRwID09IE5VTEwpIHsKICAgIGlmIChlcnJubyA9PSBFTUZJTEUpIHsKICAg
ICAgZXhpdCgxKTsKICAgIH0KICAgIGV4aXQoMSk7CiAgfQogIHN0cnVjdCBkaXJlbnQqIGVwID0g
MDsKICB3aGlsZSAoKGVwID0gcmVhZGRpcihkcCkpKSB7CiAgICBpZiAoc3RyY21wKGVwLT5kX25h
bWUsICIuIikgPT0gMCB8fCBzdHJjbXAoZXAtPmRfbmFtZSwgIi4uIikgPT0gMCkKICAgICAgY29u
dGludWU7CiAgICBjaGFyIGZpbGVuYW1lW0ZJTEVOQU1FX01BWF07CiAgICBzbnByaW50ZihmaWxl
bmFtZSwgc2l6ZW9mKGZpbGVuYW1lKSwgIiVzLyVzIiwgZGlyLCBlcC0+ZF9uYW1lKTsKICAgIHdo
aWxlICh1bW91bnQyKGZpbGVuYW1lLCB1bW91bnRfZmxhZ3MpID09IDApIHsKICAgIH0KICAgIHN0
cnVjdCBzdGF0IHN0OwogICAgaWYgKGxzdGF0KGZpbGVuYW1lLCAmc3QpKQogICAgICBleGl0KDEp
OwogICAgaWYgKFNfSVNESVIoc3Quc3RfbW9kZSkpIHsKICAgICAgcmVtb3ZlX2RpcihmaWxlbmFt
ZSk7CiAgICAgIGNvbnRpbnVlOwogICAgfQogICAgaW50IGk7CiAgICBmb3IgKGkgPSAwOzsgaSsr
KSB7CiAgICAgIGlmICh1bmxpbmsoZmlsZW5hbWUpID09IDApCiAgICAgICAgYnJlYWs7CiAgICAg
IGlmIChlcnJubyA9PSBFUEVSTSkgewogICAgICAgIGludCBmZCA9IG9wZW4oZmlsZW5hbWUsIE9f
UkRPTkxZKTsKICAgICAgICBpZiAoZmQgIT0gLTEpIHsKICAgICAgICAgIGxvbmcgZmxhZ3MgPSAw
OwogICAgICAgICAgaWYgKGlvY3RsKGZkLCBGU19JT0NfU0VURkxBR1MsICZmbGFncykgPT0gMCkg
ewogICAgICAgICAgfQogICAgICAgICAgY2xvc2UoZmQpOwogICAgICAgICAgY29udGludWU7CiAg
ICAgICAgfQogICAgICB9CiAgICAgIGlmIChlcnJubyA9PSBFUk9GUykgewogICAgICAgIGJyZWFr
OwogICAgICB9CiAgICAgIGlmIChlcnJubyAhPSBFQlVTWSB8fCBpID4gMTAwKQogICAgICAgIGV4
aXQoMSk7CiAgICAgIGlmICh1bW91bnQyKGZpbGVuYW1lLCB1bW91bnRfZmxhZ3MpKQogICAgICAg
IGV4aXQoMSk7CiAgICB9CiAgfQogIGNsb3NlZGlyKGRwKTsKICBmb3IgKGludCBpID0gMDs7IGkr
KykgewogICAgaWYgKHJtZGlyKGRpcikgPT0gMCkKICAgICAgYnJlYWs7CiAgICBpZiAoaSA8IDEw
MCkgewogICAgICBpZiAoZXJybm8gPT0gRVBFUk0pIHsKICAgICAgICBpbnQgZmQgPSBvcGVuKGRp
ciwgT19SRE9OTFkpOwogICAgICAgIGlmIChmZCAhPSAtMSkgewogICAgICAgICAgbG9uZyBmbGFn
cyA9IDA7CiAgICAgICAgICBpZiAoaW9jdGwoZmQsIEZTX0lPQ19TRVRGTEFHUywgJmZsYWdzKSA9
PSAwKSB7CiAgICAgICAgICB9CiAgICAgICAgICBjbG9zZShmZCk7CiAgICAgICAgICBjb250aW51
ZTsKICAgICAgICB9CiAgICAgIH0KICAgICAgaWYgKGVycm5vID09IEVST0ZTKSB7CiAgICAgICAg
YnJlYWs7CiAgICAgIH0KICAgICAgaWYgKGVycm5vID09IEVCVVNZKSB7CiAgICAgICAgaWYgKHVt
b3VudDIoZGlyLCB1bW91bnRfZmxhZ3MpKQogICAgICAgICAgZXhpdCgxKTsKICAgICAgICBjb250
aW51ZTsKICAgICAgfQogICAgICBpZiAoZXJybm8gPT0gRU5PVEVNUFRZKSB7CiAgICAgICAgaWYg
KGl0ZXIgPCAxMDApIHsKICAgICAgICAgIGl0ZXIrKzsKICAgICAgICAgIGdvdG8gcmV0cnk7CiAg
ICAgICAgfQogICAgICB9CiAgICB9CiAgICBleGl0KDEpOwogIH0KfQoKc3RhdGljIGludCBpbmpl
Y3RfZmF1bHQoaW50IG50aCkKewogIGludCBmZDsKICBmZCA9IG9wZW4oIi9wcm9jL3RocmVhZC1z
ZWxmL2ZhaWwtbnRoIiwgT19SRFdSKTsKICBpZiAoZmQgPT0gLTEpCiAgICBleGl0KDEpOwogIGNo
YXIgYnVmWzE2XTsKICBzcHJpbnRmKGJ1ZiwgIiVkIiwgbnRoKTsKICBpZiAod3JpdGUoZmQsIGJ1
Ziwgc3RybGVuKGJ1ZikpICE9IChzc2l6ZV90KXN0cmxlbihidWYpKQogICAgZXhpdCgxKTsKICBy
ZXR1cm4gZmQ7Cn0KCnN0YXRpYyB2b2lkIGtpbGxfYW5kX3dhaXQoaW50IHBpZCwgaW50KiBzdGF0
dXMpCnsKICBraWxsKC1waWQsIFNJR0tJTEwpOwogIGtpbGwocGlkLCBTSUdLSUxMKTsKICBmb3Ig
KGludCBpID0gMDsgaSA8IDEwMDsgaSsrKSB7CiAgICBpZiAod2FpdHBpZCgtMSwgc3RhdHVzLCBX
Tk9IQU5HIHwgX19XQUxMKSA9PSBwaWQpCiAgICAgIHJldHVybjsKICAgIHVzbGVlcCgxMDAwKTsK
ICB9CiAgRElSKiBkaXIgPSBvcGVuZGlyKCIvc3lzL2ZzL2Z1c2UvY29ubmVjdGlvbnMiKTsKICBp
ZiAoZGlyKSB7CiAgICBmb3IgKDs7KSB7CiAgICAgIHN0cnVjdCBkaXJlbnQqIGVudCA9IHJlYWRk
aXIoZGlyKTsKICAgICAgaWYgKCFlbnQpCiAgICAgICAgYnJlYWs7CiAgICAgIGlmIChzdHJjbXAo
ZW50LT5kX25hbWUsICIuIikgPT0gMCB8fCBzdHJjbXAoZW50LT5kX25hbWUsICIuLiIpID09IDAp
CiAgICAgICAgY29udGludWU7CiAgICAgIGNoYXIgYWJvcnRbMzAwXTsKICAgICAgc25wcmludGYo
YWJvcnQsIHNpemVvZihhYm9ydCksICIvc3lzL2ZzL2Z1c2UvY29ubmVjdGlvbnMvJXMvYWJvcnQi
LAogICAgICAgICAgICAgICBlbnQtPmRfbmFtZSk7CiAgICAgIGludCBmZCA9IG9wZW4oYWJvcnQs
IE9fV1JPTkxZKTsKICAgICAgaWYgKGZkID09IC0xKSB7CiAgICAgICAgY29udGludWU7CiAgICAg
IH0KICAgICAgaWYgKHdyaXRlKGZkLCBhYm9ydCwgMSkgPCAwKSB7CiAgICAgIH0KICAgICAgY2xv
c2UoZmQpOwogICAgfQogICAgY2xvc2VkaXIoZGlyKTsKICB9IGVsc2UgewogIH0KICB3aGlsZSAo
d2FpdHBpZCgtMSwgc3RhdHVzLCBfX1dBTEwpICE9IHBpZCkgewogIH0KfQoKc3RhdGljIHZvaWQg
c2V0dXBfdGVzdCgpCnsKICBwcmN0bChQUl9TRVRfUERFQVRIU0lHLCBTSUdLSUxMLCAwLCAwLCAw
KTsKICBzZXRwZ3JwKCk7CiAgd3JpdGVfZmlsZSgiL3Byb2Mvc2VsZi9vb21fc2NvcmVfYWRqIiwg
IjEwMDAiKTsKICBpZiAoc3ltbGluaygiL2Rldi9iaW5kZXJmcyIsICIuL2JpbmRlcmZzIikpIHsK
ICB9Cn0KCnN0YXRpYyBjb25zdCBjaGFyKiBzZXR1cF9mYXVsdCgpCnsKICBpbnQgZmQgPSBvcGVu
KCIvcHJvYy9zZWxmL21ha2UtaXQtZmFpbCIsIE9fV1JPTkxZKTsKICBpZiAoZmQgPT0gLTEpCiAg
ICByZXR1cm4gIkNPTkZJR19GQVVMVF9JTkpFQ1RJT04gaXMgbm90IGVuYWJsZWQiOwogIGNsb3Nl
KGZkKTsKICBmZCA9IG9wZW4oIi9wcm9jL3RocmVhZC1zZWxmL2ZhaWwtbnRoIiwgT19XUk9OTFkp
OwogIGlmIChmZCA9PSAtMSkKICAgIHJldHVybiAia2VybmVsIGRvZXMgbm90IGhhdmUgc3lzdGVt
YXRpYyBmYXVsdCBpbmplY3Rpb24gc3VwcG9ydCI7CiAgY2xvc2UoZmQpOwogIHN0YXRpYyBzdHJ1
Y3QgewogICAgY29uc3QgY2hhciogZmlsZTsKICAgIGNvbnN0IGNoYXIqIHZhbDsKICAgIGJvb2wg
ZmF0YWw7CiAgfSBmaWxlc1tdID0gewogICAgICB7Ii9zeXMva2VybmVsL2RlYnVnL2ZhaWxzbGFi
L2lnbm9yZS1nZnAtd2FpdCIsICJOIiwgdHJ1ZX0sCiAgICAgIHsiL3N5cy9rZXJuZWwvZGVidWcv
ZmFpbF9mdXRleC9pZ25vcmUtcHJpdmF0ZSIsICJOIiwgZmFsc2V9LAogICAgICB7Ii9zeXMva2Vy
bmVsL2RlYnVnL2ZhaWxfcGFnZV9hbGxvYy9pZ25vcmUtZ2ZwLWhpZ2htZW0iLCAiTiIsIGZhbHNl
fSwKICAgICAgeyIvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX3BhZ2VfYWxsb2MvaWdub3JlLWdmcC13
YWl0IiwgIk4iLCBmYWxzZX0sCiAgICAgIHsiL3N5cy9rZXJuZWwvZGVidWcvZmFpbF9wYWdlX2Fs
bG9jL21pbi1vcmRlciIsICIwIiwgZmFsc2V9LAogIH07CiAgdW5zaWduZWQgaTsKICBmb3IgKGkg
PSAwOyBpIDwgc2l6ZW9mKGZpbGVzKSAvIHNpemVvZihmaWxlc1swXSk7IGkrKykgewogICAgaWYg
KCF3cml0ZV9maWxlKGZpbGVzW2ldLmZpbGUsIGZpbGVzW2ldLnZhbCkpIHsKICAgICAgaWYgKGZp
bGVzW2ldLmZhdGFsKQogICAgICAgIHJldHVybiAiZmFpbGVkIHRvIHdyaXRlIGZhdWx0IGluamVj
dGlvbiBmaWxlIjsKICAgIH0KICB9CiAgcmV0dXJuIE5VTEw7Cn0KCnN0YXRpYyB2b2lkIGV4ZWN1
dGVfb25lKHZvaWQpOwoKI2RlZmluZSBXQUlUX0ZMQUdTIF9fV0FMTAoKc3RhdGljIHZvaWQgbG9v
cCh2b2lkKQp7CiAgaW50IGl0ZXIgPSAwOwogIGZvciAoOzsgaXRlcisrKSB7CiAgICBjaGFyIGN3
ZGJ1ZlszMl07CiAgICBzcHJpbnRmKGN3ZGJ1ZiwgIi4vJWQiLCBpdGVyKTsKICAgIGlmIChta2Rp
cihjd2RidWYsIDA3NzcpKQogICAgICBleGl0KDEpOwogICAgaW50IHBpZCA9IGZvcmsoKTsKICAg
IGlmIChwaWQgPCAwKQogICAgICBleGl0KDEpOwogICAgaWYgKHBpZCA9PSAwKSB7CiAgICAgIGlm
IChjaGRpcihjd2RidWYpKQogICAgICAgIGV4aXQoMSk7CiAgICAgIHNldHVwX3Rlc3QoKTsKICAg
ICAgZXhlY3V0ZV9vbmUoKTsKICAgICAgZXhpdCgwKTsKICAgIH0KICAgIGludCBzdGF0dXMgPSAw
OwogICAgdWludDY0X3Qgc3RhcnQgPSBjdXJyZW50X3RpbWVfbXMoKTsKICAgIGZvciAoOzspIHsK
ICAgICAgc2xlZXBfbXMoMTApOwogICAgICBpZiAod2FpdHBpZCgtMSwgJnN0YXR1cywgV05PSEFO
RyB8IFdBSVRfRkxBR1MpID09IHBpZCkKICAgICAgICBicmVhazsKICAgICAgaWYgKGN1cnJlbnRf
dGltZV9tcygpIC0gc3RhcnQgPCA1MDAwKQogICAgICAgIGNvbnRpbnVlOwogICAgICBraWxsX2Fu
ZF93YWl0KHBpZCwgJnN0YXR1cyk7CiAgICAgIGJyZWFrOwogICAgfQogICAgcmVtb3ZlX2Rpcihj
d2RidWYpOwogIH0KfQoKdWludDY0X3QgclsyXSA9IHsweGZmZmZmZmZmZmZmZmZmZmYsIDB4ZmZm
ZmZmZmZmZmZmZmZmZn07Cgp2b2lkIGV4ZWN1dGVfb25lKHZvaWQpCnsKICBpbnRwdHJfdCByZXMg
PSAwOwogIGlmICh3cml0ZSgxLCAiZXhlY3V0aW5nIHByb2dyYW1cbiIsIHNpemVvZigiZXhlY3V0
aW5nIHByb2dyYW1cbiIpIC0gMSkpIHsKICB9CiAgLy8gIG1rZGlyIGFyZ3VtZW50czogWwogIC8v
ICAgIHBhdGg6IHB0cltpbiwgYnVmZmVyXSB7CiAgLy8gICAgICBidWZmZXI6IHsyZSAyZiA3MCA2
ZCAzMiAzNCAzMiA2MyA2NiA2NyAwMH0gKGxlbmd0aCAweGIpCiAgLy8gICAgfQogIC8vICAgIG1v
ZGU6IG9wZW5fbW9kZSA9IDB4MCAoOCBieXRlcykKICAvLyAgXQogIE5PTkZBSUxJTkcobWVtY3B5
KCh2b2lkKikweDIwMDAwMDAwMDA0MCwgIi4vcG0yNDJjZmdcMDAwIiwgMTEpKTsKICBzeXNjYWxs
KF9fTlJfbWtkaXIsIC8qcGF0aD0qLzB4MjAwMDAwMDAwMDQwdWwsIC8qbW9kZT0qLzB1bCk7CiAg
Ly8gIG1vdW50IGFyZ3VtZW50czogWwogIC8vICAgIHNyYzogbmlsCiAgLy8gICAgZHN0OiBwdHJb
aW4sIGJ1ZmZlcl0gewogIC8vICAgICAgYnVmZmVyOiB7MmUgMmYgNzAgNmQgMzIgMzQgMzIgNjMg
NjYgNjcgMDB9IChsZW5ndGggMHhiKQogIC8vICAgIH0KICAvLyAgICB0eXBlOiBwdHJbaW4sIGJ1
ZmZlcl0gewogIC8vICAgICAgYnVmZmVyOiB7NjMgNmYgNmUgNjYgNjkgNjcgNjYgNzMgMDB9IChs
ZW5ndGggMHg5KQogIC8vICAgIH0KICAvLyAgICBmbGFnczogbW91bnRfZmxhZ3MgPSAweDAgKDgg
Ynl0ZXMpCiAgLy8gICAgZGF0YTogbmlsCiAgLy8gIF0KICBOT05GQUlMSU5HKG1lbWNweSgodm9p
ZCopMHgyMDAwMDAwMDAwODAsICIuL3BtMjQyY2ZnXDAwMCIsIDExKSk7CiAgTk9ORkFJTElORyht
ZW1jcHkoKHZvaWQqKTB4MjAwMDAwMDAwMGMwLCAiY29uZmlnZnNcMDAwIiwgOSkpOwogIHN5c2Nh
bGwoX19OUl9tb3VudCwgLypzcmM9Ki8wdWwsIC8qZHN0PSovMHgyMDAwMDAwMDAwODB1bCwKICAg
ICAgICAgIC8qdHlwZT0qLzB4MjAwMDAwMDAwMGMwdWwsIC8qZmxhZ3M9Ki8wdWwsIC8qZGF0YT0q
LzB1bCk7CiAgLy8gIG9wZW5hdCRkaXIgYXJndW1lbnRzOiBbCiAgLy8gICAgZmQ6IGNvbnN0ID0g
MHhmZmZmZmZmZmZmZmZmZjljICg4IGJ5dGVzKQogIC8vICAgIGZpbGU6IHB0cltpbiwgYnVmZmVy
XSB7CiAgLy8gICAgICBidWZmZXI6IHsyZSAyZiA3MCA2ZCAzMiAzNCAzMiA2MyA2NiA2NyAyZiA2
ZSA3NSA2YyA2YyA2MiAwMH0gKGxlbmd0aAogIC8vICAgICAgMHgxMSkKICAvLyAgICB9CiAgLy8g
ICAgZmxhZ3M6IG9wZW5fZmxhZ3MgPSAweDAgKDQgYnl0ZXMpCiAgLy8gICAgbW9kZTogb3Blbl9t
b2RlID0gMHgwICgyIGJ5dGVzKQogIC8vICBdCiAgLy8gIHJldHVybnMgZmRfZGlyCiAgTk9ORkFJ
TElORyhtZW1jcHkoKHZvaWQqKTB4MjAwMDAwMDAwMTAwLCAiLi9wbTI0MmNmZy9udWxsYlwwMDAi
LCAxNykpOwogIHJlcyA9IHN5c2NhbGwoX19OUl9vcGVuYXQsIC8qZmQ9Ki8weGZmZmZmZmZmZmZm
ZmZmOWN1bCwKICAgICAgICAgICAgICAgIC8qZmlsZT0qLzB4MjAwMDAwMDAwMTAwdWwsIC8qZmxh
Z3M9Ki8wLCAvKm1vZGU9Ki8wKTsKICBpZiAocmVzICE9IC0xKQogICAgclswXSA9IHJlczsKICAv
LyAgbWtkaXJhdCBhcmd1bWVudHM6IFsKICAvLyAgICBmZDogZmRfZGlyIChyZXNvdXJjZSkKICAv
LyAgICBwYXRoOiBwdHJbaW4sIGJ1ZmZlcl0gewogIC8vICAgICAgYnVmZmVyOiB7NzAgNmQgMzIg
MzQgMzIgNzIgNjUgNmMgMDB9IChsZW5ndGggMHg5KQogIC8vICAgIH0KICAvLyAgICBtb2RlOiBv
cGVuX21vZGUgPSAweDAgKDggYnl0ZXMpCiAgLy8gIF0KICBOT05GQUlMSU5HKG1lbWNweSgodm9p
ZCopMHgyMDAwMDAwMDAxNDAsICJwbTI0MnJlbFwwMDAiLCA5KSk7CiAgc3lzY2FsbChfX05SX21r
ZGlyYXQsIC8qZmQ9Ki9yWzBdLCAvKnBhdGg9Ki8weDIwMDAwMDAwMDE0MHVsLCAvKm1vZGU9Ki8w
dWwpOwogIC8vICBvcGVuYXQgYXJndW1lbnRzOiBbCiAgLy8gICAgZmQ6IGZkX2RpciAocmVzb3Vy
Y2UpCiAgLy8gICAgZmlsZTogcHRyW2luLCBidWZmZXJdIHsKICAvLyAgICAgIGJ1ZmZlcjogezcw
IDZkIDMyIDM0IDMyIDcyIDY1IDZjIDJmIDZkIDY1IDZkIDZmIDcyIDc5IDVmIDYyIDYxIDYzIDZi
CiAgLy8gICAgICA2NSA2NCAwMH0gKGxlbmd0aCAweDE3KQogIC8vICAgIH0KICAvLyAgICBmbGFn
czogb3Blbl9mbGFncyA9IDB4MSAoNCBieXRlcykKICAvLyAgICBtb2RlOiBvcGVuX21vZGUgPSAw
eDAgKDIgYnl0ZXMpCiAgLy8gIF0KICAvLyAgcmV0dXJucyBmZAogIE5PTkZBSUxJTkcobWVtY3B5
KCh2b2lkKikweDIwMDAwMDAwMDFjMCwgInBtMjQycmVsL21lbW9yeV9iYWNrZWRcMDAwIiwgMjMp
KTsKICBpbmplY3RfZmF1bHQoNyk7CiAgc3lzY2FsbChfX05SX29wZW5hdCwgLypmZD0qL3JbMF0s
IC8qZmlsZT0qLzB4MjAwMDAwMDAwMWMwdWwsCiAgICAgICAgICAvKmZsYWdzPU9fV1JPTkxZKi8g
MSwgLyptb2RlPSovMCk7CiAgLy8gIG9wZW5hdCBhcmd1bWVudHM6IFsKICAvLyAgICBmZDogZmRf
ZGlyIChyZXNvdXJjZSkKICAvLyAgICBmaWxlOiBuaWwKICAvLyAgICBmbGFnczogb3Blbl9mbGFn
cyA9IDB4MSAoNCBieXRlcykKICAvLyAgICBtb2RlOiBvcGVuX21vZGUgPSAweDAgKDIgYnl0ZXMp
CiAgLy8gIF0KICAvLyAgcmV0dXJucyBmZAogIHJlcyA9IHN5c2NhbGwoX19OUl9vcGVuYXQsIC8q
ZmQ9Ki9yWzBdLCAvKmZpbGU9Ki8wdWwsIC8qZmxhZ3M9T19XUk9OTFkqLyAxLAogICAgICAgICAg
ICAgICAgLyptb2RlPSovMCk7CiAgaWYgKHJlcyAhPSAtMSkKICAgIHJbMV0gPSByZXM7CiAgLy8g
IHdyaXRlIGFyZ3VtZW50czogWwogIC8vICAgIGZkOiBmZCAocmVzb3VyY2UpCiAgLy8gICAgYnVm
OiBwdHJbaW4sIGJ1ZmZlcl0gewogIC8vICAgICAgYnVmZmVyOiB7MzEgMGF9IChsZW5ndGggMHgy
KQogIC8vICAgIH0KICAvLyAgICBjb3VudDogbGVuID0gMHgyICg4IGJ5dGVzKQogIC8vICBdCiAg
Tk9ORkFJTElORyhtZW1jcHkoKHZvaWQqKTB4MjAwMDAwMDAwMjgwLCAiMVxuIiwgMikpOwogIHN5
c2NhbGwoX19OUl93cml0ZSwgLypmZD0qL3JbMV0sIC8qYnVmPSovMHgyMDAwMDAwMDAyODB1bCwg
Lypjb3VudD0qLzJ1bCk7CiAgLy8gIHJtZGlyIGFyZ3VtZW50czogWwogIC8vICAgIHBhdGg6IHB0
cltpbiwgYnVmZmVyXSB7CiAgLy8gICAgICBidWZmZXI6IHsyZSAyZiA3MCA2ZCAzMiAzNCAzMiA2
MyA2NiA2NyAyZiA2ZSA3NSA2YyA2YyA2MiAyZiA3MCA2ZCAzMgogIC8vICAgICAgMzQgMzIgNzIg
NjUgNmN9IChsZW5ndGggMHgxOSkKICAvLyAgICB9CiAgLy8gIF0KICBOT05GQUlMSU5HKG1lbWNw
eSgodm9pZCopMHgyMDAwMDAwMDAyYzAsICIuL3BtMjQyY2ZnL251bGxiL3BtMjQycmVsIiwgMjUp
KTsKICBzeXNjYWxsKF9fTlJfcm1kaXIsIC8qcGF0aD0qLzB4MjAwMDAwMDAwMmMwdWwpOwp9Cmlu
dCBtYWluKHZvaWQpCnsKICBzeXNjYWxsKF9fTlJfbW1hcCwgLyphZGRyPSovMHgxZmZmZmZmZmYw
MDB1bCwgLypsZW49Ki8weDEwMDB1bCwgLypwcm90PSovMHVsLAogICAgICAgICAgLypmbGFncz1N
QVBfRklYRUR8TUFQX0FOT05ZTU9VU3xNQVBfUFJJVkFURSovIDB4MzJ1bCwKICAgICAgICAgIC8q
ZmQ9Ki8oaW50cHRyX3QpLTEsIC8qb2Zmc2V0PSovMHVsKTsKICBzeXNjYWxsKF9fTlJfbW1hcCwg
LyphZGRyPSovMHgyMDAwMDAwMDAwMDB1bCwgLypsZW49Ki8weDEwMDAwMDB1bCwKICAgICAgICAg
IC8qcHJvdD1QUk9UX1dSSVRFfFBST1RfUkVBRHxQUk9UX0VYRUMqLyA3dWwsCiAgICAgICAgICAv
KmZsYWdzPU1BUF9GSVhFRHxNQVBfQU5PTllNT1VTfE1BUF9QUklWQVRFKi8gMHgzMnVsLAogICAg
ICAgICAgLypmZD0qLyhpbnRwdHJfdCktMSwgLypvZmZzZXQ9Ki8wdWwpOwogIHN5c2NhbGwoX19O
Ul9tbWFwLCAvKmFkZHI9Ki8weDIwMDAwMTAwMDAwMHVsLCAvKmxlbj0qLzB4MTAwMHVsLCAvKnBy
b3Q9Ki8wdWwsCiAgICAgICAgICAvKmZsYWdzPU1BUF9GSVhFRHxNQVBfQU5PTllNT1VTfE1BUF9Q
UklWQVRFKi8gMHgzMnVsLAogICAgICAgICAgLypmZD0qLyhpbnRwdHJfdCktMSwgLypvZmZzZXQ9
Ki8wdWwpOwogIGNvbnN0IGNoYXIqIHJlYXNvbjsKICAodm9pZClyZWFzb247CiAgaWYgKChyZWFz
b24gPSBzZXR1cF9mYXVsdCgpKSkKICAgIHByaW50ZigidGhlIHJlcHJvZHVjZXIgbWF5IG5vdCB3
b3JrIGFzIGV4cGVjdGVkOiBmYXVsdCBpbmplY3Rpb24gc2V0dXAgIgogICAgICAgICAgICJmYWls
ZWQ6ICVzXG4iLAogICAgICAgICAgIHJlYXNvbik7CiAgaW5zdGFsbF9zZWd2X2hhbmRsZXIoKTsK
ICB1c2VfdGVtcG9yYXJ5X2RpcigpOwogIGRvX3NhbmRib3hfbm9uZSgpOwogIHJldHVybiAwOwp9
Cg==
--000000000000d885fe06530c25bc--
