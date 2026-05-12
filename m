Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD61DF75B
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 05:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562349; cv=pass; b=gixatwh/TzhTSPUgV3+o2KM6VVk5lIqV43EdN1gFv06MZyyqzdH6KB7CfuEzPob/SPrf2h87/RmhC4uYPwT+zBnhwCOok6wb4Fd2RZmH/9ZqLAxKEwD6NZiigcN0oVb4cLrO6H/4Tehbc5rKxfqor6RsThCiRgzFHqcNvTob3So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562349; c=relaxed/simple;
	bh=QDigh/IC+tvvwpywNZ8uKY4YppeM0413gxpNV2iy/0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7E5mQ6wGjU6lZ/plso6EGFC6gwqD3RRDG/GcGgxYq5gWqX9AO8MBSjiRMJ/QKEITFJ4nlnMd62Qx56JitLOGVDre3mCNZjGapnnFD+A3eda2MAG3pHQhrHHZrjXlhxuzo2sudL5zY3q8+xSrgbf5lp+S9J3tQaO1q8otDWNitM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSSkUoPp; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSSkUoPp"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso57576985e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 22:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778562346; cv=none;
        d=google.com; s=arc-20240605;
        b=LyJfGq/s2LxWwqOQHY4hUibifv10mGSL779uRQyThe1CM3xnn33zC9Y2vUp1SmfUAV
         KMHKUjQX2xomB6enFUBoM+j89iA6VYQCVMuj+Fivv0ZdZSuMOb/SczYwLRH8KBpEr38O
         torVu0YIajoUoQZkf6M373mj0HuUAhFEkXFJevLlCKeLrJZ//IFi7QvNzmMI0jILb/xr
         cQP5xMy37J6RjmgynYeKgwmmHGsz8CXMbHE62lsTWSCkjHwoW6Bv7KPhI1vDG43Czubo
         x+hP7in/TJ+/O9t5Uk2FLl/pbIR9qU6TPV2xeewuBAJXrhKA8FcTIKWtudT79Y+Lk5UX
         +Ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jmieOXb38ndzyje8PODRQfdgkAbT1kd6c7uzPdMO3Wk=;
        fh=shpFUnTo7hUO4wHnTz8kezWJoVXWXfy/hLF8jIQg/LY=;
        b=IAsrp+gfi8k+EONXFCyxp4i8VO5DcHksv+TDAjQEZ1Nx464/A6wH5hj5VHKMAf3s7f
         PbzV59qR2rTS0QzX4AqSWJhoGsVnTwBQNtIoDNaoD5iiwVtZlOnNaW5wj/9f60buWvqy
         kPCKYom7Lp1lLrjSkDypWjR1iscpcGe6NCFsYxueWGIhqyreHJIXz7DuikDj3GId6F1U
         aC/EUAEMdk9VQDFSgU2bJe1LrRmGYwc+pP/AC/zCOvmhIs6C9AWZVeQ00ABWkCRDzD2+
         Jj+aK2ZbTzjvjWeG9NXjsxttJfduxQoD1GimYldAQFdoLJWo1TITwGTANU24zXxOqkWA
         GerQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778562346; x=1779167146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmieOXb38ndzyje8PODRQfdgkAbT1kd6c7uzPdMO3Wk=;
        b=OSSkUoPpEhNBEw3XxS/UXycsOUyxjX3THvtI4CpmcPQ60FbkE7wqBh3T1nfyoHaht6
         v0b24MqF03eq2gk+fw2yOIwytL6EQpD21TlXyRhN7NwcxU/GevmkQE/xOkvD117Et76u
         sLNMTaUuiNCKmkuzECvgH72QSdAhzZelrwP0Clt5/bLs0UUgyTeEHp2mbnPtItXm72O/
         6QROt4h7qYOIpZxigVxPS1aYD+6eQ3zYXlMSeutU4NJKEbkMf2HbGUAWLegGC5bngKVx
         +flKo3CVZ1W8n6shnEvnrS3ZlUD4yqR/6zwNntCWolo5xyaeEQV9pSBX0Lr+Mm1MRpvs
         yepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778562346; x=1779167146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jmieOXb38ndzyje8PODRQfdgkAbT1kd6c7uzPdMO3Wk=;
        b=HL/M9P1MCfKV1yt2IvzEFFSqtdICLFi+cOn47NJFz+EUEeIs1A6aaBtJ6dhvtXpSiD
         TV6WlTRGciY2GS2DnHv1BNm8b8G36Vh579CXiB7Pus8b44t/Q+TpF8fkacxw/T9qF2nM
         NdJ86gjB1qTVV2N+nYgIDLHW7Z88pNKtITOulwDc8JP+Eu5QjG2sSgmyCgXGFiVmWB5r
         wJaVkmE71P6G/uDQmyr6LZT38tkqaSHdbCiUt2bvSWBe9XWG7h3mE8UiPiQDKgrTfktq
         7vUov6g7dqUPDU9VPc0Zk6Pq8yljIW5Vdza9ZzezjhF5yzDRYjwEfEIqS/8Owv545XOJ
         sk2A==
X-Forwarded-Encrypted: i=1; AFNElJ8uHvJ7vDFrt2tyv8deQGyLM8enidXRpA1Y1ivDGquPQRO5G2LX4kPYYfhb642d6IdS28tZqv8TgdZhNqoy@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ2AZgKWHw4kL6B4SWpP3FAWcuyB8q58kZFhjTftIW86joYRNv
	sN62LSFAdY/fGG18gEoFG6sFqchKFjDHC8WUjSGfKbPB1ZmP4GLOu6E/PagWsFj28IQR/bPfamv
	gZwvCOrF3STbH0JihyFz8WhNwXtjTnuI=
X-Gm-Gg: Acq92OHn+sEwzyD+0Hsjthj5ZhCkL+qKGWo7G3J413e4r9sfgldfJko1U92AwE89D7G
	IKZgl0AVDo+J9C4M2LGkh7+3x7180OWiKdocbCUrFf2WunLOpqrYSRUuJdZq4nqb4mOMOZr0/mv
	C2M+RSvlD9pbtuL3eU0fa/AOGc6cswXtec39tS8AUDKaCvwAk+4XNZbjidEzqNq5uyMwvOmiH94
	jFUqGSAmFgetycBaZGUbMFd+rizeEwehq6xKEj6FO7/gCzFwQXir8PExLJwW7W2s4ZR89AI+vtD
	NyOAKQ==
X-Received: by 2002:a05:600c:1791:b0:48e:635a:18c3 with SMTP id
 5b1f17b1804b1-48e8e1f014fmr18306935e9.4.1778562345821; Mon, 11 May 2026
 22:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com>
In-Reply-To: <20260429102058.1362965-1-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 11 May 2026 22:05:33 -0700
X-Gm-Features: AVHnY4Kq57pSzRvHov0wVqjXddRKFwJocV5axrPcF3ro5uRNbecHuRzIiIYEJZE
Message-ID: <CAJnrk1Z_JWtuA3UjucF9=YH63AH_-J_0hzr9jbY99Hx3O8YrAw@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:21=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> This stands for "fuse extended/experimental".
>
> The purpose is to provide a clean base for big features like the FUSE_IOM=
AP
> api.
>
> It's also a good way to try new stuff like file handles and compound
> requests without the risk of breaking something in the large and complex
> fuse codebase.
>
> Whether these features will be migrated back into the main fuse codebase,
> or fusex is going to end up as a major version update is still up in the
> air.

Could you explain a bit what the main motivation behind fusex is? Is
it mainly to clean up interfaces that are now clunky/stale? Or is it
more driven by limitations in the current codebase that make newer
features hard to add? From the paragraphs above, it kind of seems like
the latter?

If it's mostly to clean up interfaces that are now clunky/stale, I
wonder if now is the best time given that, as Amir phrased it in [1],
"FUSE is experiencing a renaissance of new features and protocol
enhancements", and I'm not sure if we know yet if these new interfaces
will also have some things we'll have wished in hindsight we had done
differently, especially since some of these new features are still
actively evolving and gaining new capabilities (including io-uring and
passthrough). Would it make sense to let these new features and
protocol enhancements evolve and stabilize first before baking them
into fusex?

There's a good chance I'm missing something here, but if fusex is
mostly to make new features easier to add, I'm not sure I see a lot of
difference between doing it in fuse vs fusex when fusex is expanded to
have feature-parity with legacy fuse. Is there something in particular
that fusex makes easier?

I wonder if libfuse could serve as a bridge for the gap between legacy
fuse and fusex, eg libfuse filling any missing gaps / translating
between legacy fuse protocols and fusex protocols such that any fuse
server written for legacy fuse could run using fusex, which would
remove the need to have to do any "backporting" to legacy fuse for new
features that are added to fusex and could accelerate the deprecation
timeline of legacy fuse.

>
> Major differences from regular fuse:
>
>  - local filesystem mode only
>  - only synchronous FUSE_INIT is supported

Some other things that might be nice:
* handle_killpriv / handle_killpriv2 - sgid/suid + file capabilities
clearing will always be handled by the server (default implementation
in libfuse)
* in fuse io-uring: headers and payload passed together as one
contiguous buffer during registration for pinning, deprecate passing
separate buffers per SQE
* in passthrough: backing_fd passed at lookup/creation time only (not
at open time), expanded struct fuse_backing_map

>  - only no-open mode
>  - new requests:
>    + FUSE_LOOKUP_ROOT - return nodeid of root
>    + FUSE_LOOKUPX - FUSE_LOOKUP without the getattr

Could you explain why it's preferred to have lookup disentangled from
attributes, eg why compounding lookup + attribute fetching is
preferred over embedding the statx directly inside the lookup request
without compounding? it was brought up in Luis's lookup handles
patchset [2] but it's still a bit unclear to me why compounding the
two is better. I think every operation/request that returns a struct
fuse_entry_out uses the attributes immediately after through
fuse_iget(..., &outarg->attr, ...) or fuse_change_attributes(...,
&outarg.attr, ...), so the attributes seemed pretty tightly
intercoupled with lookup from what I could see.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjRgQGxWYWbRbjVZy19oA5qKZSd=
9eANKyD8yCoBNGPNNw@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20260225112439.27276-1-luis@igali=
a.com/T/#t

>    + FUSE_MKOBJX - merged FUSE_MKNOD, MKDIR, SYMLINK and TMPFILE
>    + FUSE_SETSTATX - extended version of FUSE_SETATTR
>
> Missing features:
>
>  - file handles / export ops
>  - compound requests
>  - xattr caching
>  - fileattr
>  - fiemap
>  - ioctl
>  - copy_file_range
>  - lazy dir open
>
> Test server can be found at:
>
>   https://github.com/szmi/fuse-utils
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>
> Patch is against
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-nex=
t
>
>  fs/fuse/Makefile          |    2 +-
>  fs/fuse/args.h            |    1 +
>  fs/fuse/dev.c             |   13 +-
>  fs/fuse/dir.c             |    4 +-
>  fs/fuse/fuse_i.h          |    8 +
>  fs/fuse/fusex.c           | 1751 +++++++++++++++++++++++++++++++++++++
>  fs/fuse/fusex.h           |    4 +
>  fs/fuse/inode.c           |   16 +-
>  include/uapi/linux/fuse.h |   36 +
>  9 files changed, 1826 insertions(+), 9 deletions(-)
>  create mode 100644 fs/fuse/fusex.c
>  create mode 100644 fs/fuse/fusex.h
>
