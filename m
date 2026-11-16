Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794859647;
	b=peXmlkhdx1Pnlgc+JKxAfZ1s0X+bgyIzkOhYJ9cZRL2fc5aPL5Ee7LdVrRg96l1AsMMR
	 NLH8AoM9WvDbyacIzxpBWmZ4of+DCARy2FEd69+prvduQF7Q+TXnPKKJUJNexkO9L5X7T
	 tbJV41IYXfnuX1+2zEPuYpMfMem4ERlq06QqcnIcb+qN3rVyeAlpmYQEHhrSeH6KAmArf
	 oNeAWXnDR4K0hOILc04ybUl1Dv7XFCZuyARHGiVJ1JSoPmruGhxUBNcU7pKly9vbocjjv
	 wIPNSJQvCN4F37ngIRHbInSh89wxe51v9tk7mmTMMuFIcnpAxYKUyFap7ZATzalxoNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
	b=yOPGuZMJdyqosLuPC+h1Ys8seG5ITi2ktBlqHrJabbOHKlYvGm7AbWpmxLWBMr4CwfOZ
	 pMw+XA1BZDieHXRdJVCVq1P8gBb2lvlJnSaLfntWHXXeLBtAgRxnfDLTMwjJ2QgMimE15
	 afWq9BEWX0APi4XYb01DdGthWYZS9uNkKdi/6b7V591SqmlVgjO49w25QBg1bIM4IrOIf
	 pnnLMA9WqKNQUg9KVU7NrYGc7dBBptrDIYPYIfAdot4WVGdN06cSi2Odg9lPHqnb4h7JX
	 5RKJu/dhea8Td6auSQbsur2+BgbDKYpscDHhC5I/5i1ro4Blo/OmIQ6UnIky96xOxsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XFDBy0c2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E50606A88A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 20:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26E50606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XFDBy0c2
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso24829915e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794859644; cv=none;
        d=google.com; s=arc-20260327;
        b=mzCQe1JulnqF1ez296ROaGWijPVfz6bhPhCFcdcxhWwz3Ze4GZbF45VDItEdCkHP2f
         QIOmryK2Tt/P0T3kF/r59YogKBQ8N3FRdfq8sILxOnU9fWkeh8itWuL0ThdMpCvJhSi5
         6w6ChVRlU14SLKOoSgkqvU6bu859hssw5J9ISZYhX/DeYLVyeKJKd9gwerN3GUs7iK8H
         yE/8gVzd6v1gTU73AVoYIkXYiqdWsnITBEThRSFj8rrmprx+efjIOq+YRUH2UsNQTpdb
         RJjbnUg9DvW/jbj9WhK14CCUWl1VTMbbjzp1k8TWUAztR3sNgFiLc5DJc5TJi2cxMmpd
         AwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        fh=yCgN7N9+0RIcyfjOYXXG2H1nyUyf4vQwDbvAYAU3++o=;
        b=PmIL1fBtnC2IeQnd1/LacPhUJrOoCS3A4Xk5lheGDuBHghXGIU4rsPQ4NVoDSzh5n+
         0FEOEtD5VmxzSXhbl9LfZXDHVpLTNyE5emCqz8BM3sAmDnbm5RxAOaekRBl0Q8UsAehw
         lnlR7qquxIUeSyApQF1gzSod6hOc5aeRRAm3yajqpPDePD8Hyg/sO7i5DuWkdhiXlH0R
         i2pwHn1aqJG4EVjO/zfCzM9AzG3tiPDJWXv/hKVmP452WTpR3RSQoquD+F0ttSsW979N
         Zyl5CX0ZPgKk1R6r0n9RKybXIo2f0gexrUE0uwn4JTpEItTLiHpnTgZypR4h6Ncfbccn
         qVmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859644; x=1795464444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        b=XFDBy0c2q6nTYiJ4dwLENH1mguXX/IcFF58gOeYQArjps79P1XpkrhGZpUclTyZwpS
         r/ZYwRoOG8WhRg+8JvLZN08T5FQLHs7jA/CzeQCQsJeulI93s02F+iYtli/pBjYHG+CR
         W2MoU0n/+grSPpLZW83MAsn9WQiLh5CCwtBf/0GxLqRHC416IFZ4i13TeIFhLxmbz0il
         NPxDzLDOL7N17VVYsTOL0jDLDvB5woBcjlvcU+oGB0Wrnz6q9rCc3VHuwmdjl71ac6+n
         fuvYHmykPJU4vuSvTSKMetyKY9BqLddb2of0qXOJ87q21uNxSrudqkhk+T/+cyqihyd7
         2YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859644; x=1795464444;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        b=A8b2otyTrH6CfARsnef8wVTZT2gDay9lmkHVtT5R//E5Bq82NZLBD1l0AA64cXJokF
         tahAndlLMmzbMObLbyiqxzKnxOvDWYbkuI8HYCTxnvyQI9XfH/fZLCzLgKMCcDl9SUDv
         kPyf5axG/vsro4R8Zx4vnbv8ovk1LrheLoqDzQq2AvzmfcLW8YQk0v5ucHbEB6GzWAXJ
         6sDkcdSkose8alTgHPmdutKF30BT498qrC5JxV/oR43MZCdYa+glh5S5fZsrGaoHW/+e
         WFdepFAxTlLMJodvxcPmMkj4k1rVh75NB/YtiCSlJ6dDLeNM7ufO9nVhZ3atB9xHK9Wu
         3Qbg==
X-Forwarded-Encrypted: i=1; AL+hErFkkxaamGRnx31M+ZYu2ZsaGAoiidbYaC+nSCtDH0V4P1bsvjr2PaksSEWinR4D5nY6fhiWFYTTr/qx4p1j@vger.kernel.org
X-Gm-Message-State: APuU4Z8yCGDxA8tQuDuS9p20zwVoxhudKAJxez75xa+oPLBMy816j+uK
	emaudAJ6JqgPnWe93aXmF+8BsXfarDY+LRgHbK1uVK0/irYD1lxsC4UV/RozRqkDooiCqi0mVJh
	XDYs0b9UjmAOmLGIAXsFbG2eVysRZ4GA=
X-Gm-Gg: AYBFou33dtaXOX5qS/zD9IIDyWBPRq8moKl8007QbUhW/Rcw0Ci7Kss7eJJv2A/dpZ3
	kgtPcT5x4WhhfN5JlemfsieQeCSTlXEO2+5TENA5bk24LACa+NF+4SpGidOVX+TpBXkbZD/kVRP
	tLSlSABqmNh0eVu5M9UXxjK+ynBQFnFQvjxcZryJA6++w/HnVg3i1r/J/hcA4y74WYiStUUUE3Y
	HJ8EeXsVxS1SqGm+bxYLimnSXMiNFnZ1hAr7Et/24jn/EMce0LSF8Z7iNm6gGoumZKLcixc7Vbx
	PtS2GeT/huA8sX2EzsfBpnlv8FUz/rlw3zHOvSj4U05KQ9xXU/GnIAWDoprW//1nSDhgHGUcNWM
	o68j1u4KGi46V+PReB9YEsh0di9rngdrgAFbHXac1gq2f4QCKtfvW0CZBgTgcUYNWBfxbpMKhrK
	b2ZsrwI/1PDDVd8Du/cw==
X-Received: by 2002:a05:600c:506:b0:4a1:f377:5c6c with SMTP id
 5b1f17b1804b1-4bb55a5d6bbmr165067875e9.10.1794859644313; Mon, 16 Nov 2026
 12:07:24 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org> <20261116-work-fs-frozen_writes-v2-13-ecc4a2aac40e@kernel.org>
In-Reply-To: <20261116-work-fs-frozen_writes-v2-13-ecc4a2aac40e@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 12:07:13 -0800
X-Gm-Features: Aa3M54rpWiCplKeR8o5TX-NbYGDID_36BWk-3VAyUzdEoXSYZ7J-t8pfWvm9Fcc
Message-ID: <CAEf4BzYANM9vtQ8L9-rJPQC-tTcw3YUGsw=qnCaoym3+EU=DBg@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] bpf: fs/xattr: take freeze protection in the
 xattr kfuncs
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 3:13=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> bpf_set_dentry_xattr() and bpf_remove_dentry_xattr() go through
> __vfs_setxattr() and __vfs_removexattr() which leave freeze protection
> to the caller. BPF LSM programs call them from sleepable hooks such as
> file_open where nobody holds it. So a program can modify a frozen
> filesystem.
>
> The hook may already hold freeze protection or locks a frozen
> filesystem would make us wait under. So don't wait for a thaw. Fail
> with -EBUSY if the filesystem is frozen.
>
> The _locked variants are only used from hooks that run inside setattr,
> setxattr, removexattr, unlink and rmdir. Their callers hold freeze
> protection already.
>
> Fixes: 56467292794b ("bpf: fs/xattr: Add BPF kfuncs to set and remove xat=
trs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 35ccd98a4de64..7f61e2efa08ba 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -295,9 +295,13 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *=
dentry, const char *name__st
>         if (!inode)
>                 return -EINVAL;
>
> +       /* The hook may hold locks or freeze protection already. */
> +       if (!sb_start_write_trylock(inode->i_sb))
> +               return -EBUSY;
>         inode_lock(inode);
>         ret =3D bpf_set_dentry_xattr_locked(dentry, name__str, value_p, f=
lags);
>         inode_unlock(inode);
> +       sb_end_write(inode->i_sb);
>         return ret;
>  }
>
> @@ -323,9 +327,13 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentr=
y *dentry, const char *name_
>         if (!inode)
>                 return -EINVAL;
>
> +       /* The hook may hold locks or freeze protection already. */
> +       if (!sb_start_write_trylock(inode->i_sb))
> +               return -EBUSY;
>         inode_lock(inode);
>         ret =3D bpf_remove_dentry_xattr_locked(dentry, name__str);
>         inode_unlock(inode);
> +       sb_end_write(inode->i_sb);
>         return ret;
>  }
>
>
> --
> 2.53.0
>
>
