Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793352418;
	b=lAXf8tdgr+B/CXgWiIUgaJgC/XhDjCP4HWpX+bh+/6GFAJm7+PKO8+uEbhBZoz55AIME
	 7i3S4+TW8Q40AQqliOJ27oDIXdKUpjV2KXjp/uNZ58oCVhPQqDRAIihS1epY8nIdNvyCS
	 jrTcjf4NT5kU+wCohOKUbn7VGuNRc02fCDKHUdKYCfiYb1Edrwc7d9hmGFUplVftAkCQd
	 +X++VRl+lT+eNgyLRjsi7SOLkP//D4vs/uMg6jtHRWw5fXXgZGlJ7ijCJy035VosuKG5Y
	 lUW8xuolKc9xO+FtXlCjb7irva+DEtr7PGR4aa5kbGZNFFL5MxoarNuGxeqTBp0fr3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=a7q+/4+4zxMUP673wzD4KRVvcydFuIy84hUuAGiF6LM=;
	b=0r4ITd0BTWOnA5ZPOHBnZde1hiK4vFgy+g55evdAFllkFEI6jIcM+2BOs7S3WNylEur3
	 cwXFnTLia0NEtgizEz878jqQOLyf8Koctc53GrSfii+DCdPuHRDulZN73ZaALM7J9wJ3+
	 GO1+segwwIl+AzsTX6QeLuow+H10bKy37kzvooO5y6ZjiysCn0riNZEda5QZPppfAFFBy
	 lM+HLAJhs1M0+4PIZj79Ri/XSayS9kJ8/EQwNcJ2uwfb6/+/ZpoCJ15jfIARRV6mATYMz
	 MVVDMA4/Ju9QBZqfsXhaSR90LXVVDVO+/72vxRDH/1f2IN3tSlwsxQmyNT0hRymRuZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ayciZqaX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61242606A320
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 09:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61242606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ayciZqaX
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2e8c710847so66785066b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 02:26:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793352416; cv=none;
        d=google.com; s=arc-20260327;
        b=DTXG+Sq8DkZDqWNaaKTGrj63IQtpPTxy7BVLF27ugNd4zZh0NrwebuFJlhWPaUsJWt
         viPP9bomb2J42Ik2TTdYg+z7tB//gAfD2JIquEXp2eALZOO097Z89B4xee12E0YwDlbJ
         kBHT29HUnG67hkZ/6sus5FWl9Tpcc5tE/oGV7HzQqlFrtDRb5jto7xwUAG/GkQ6yeIQ5
         yz3QBtL9SzyRxcD2vAqfgAHTtaNI3ic/BmC47IlDi0pcxpyfHz+VrcM6XRpu6kZtGBiv
         JHPeuys1ihKBaMkt2ajHTcsstzZ175hJKQ9EMV821oVLdTN9VdpkvRREq4oyA/YVcde8
         vE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a7q+/4+4zxMUP673wzD4KRVvcydFuIy84hUuAGiF6LM=;
        fh=eixrBlcU7I0mcAPxPNR8PxfYalagLsITqHE6rTKZN4g=;
        b=ityklTqCdRtXsWHUPkCff0TPI7STHxHLQYzxKOGvoiy2CMvEFEjQ2FJ/XDeOIxovcG
         XETppqbGy3cQb8309TfJ/ZDVaNStE3gWpuue/zLXCtVa+jyxQpROe2i2qYjKdneEaiZ+
         7GUtv0CLT6/m609O4J8QQgLRz7606mSSwg/39x4N8eBQzAmL4p/YUuDGhPP6NWJyX4BK
         R7EQZ7WUOS7YJxbqExtSCzPfvDgslHzI2UgFFWnKDC9U8aXly4PQCGzBcXjxw/Jn2xrb
         E10YDNFFYrxWU7ADAcjdFD1xy70qCtIsWgLj0b+5kT8Md2hjs9YC+Tbd00HNYGebmnCI
         CyjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793352416; x=1793957216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a7q+/4+4zxMUP673wzD4KRVvcydFuIy84hUuAGiF6LM=;
        b=ayciZqaXdQP8kxCzQupvDq5/ksF/5+X55nmxdHSDPXRtmFf8SIUDZkZaCXg6JnRxZT
         /PTNG35skuMUuytLlEpxoAJQ6sNewaygA79NJwF8mxa/zBRUdamK5O6BmpwPv3afvnYc
         NJ8Hbr3+omGNtgKFNtMzEGPHzmcIS3++nOUYbqexCw6Ob9qX3CD3rpUt2Ukp7kJZT264
         NpxOo0kDthQ25ZLLxaw87HUmbG7uFxnkhcYvmkjcaZXyCnX6/5bGiw55XEbK57jZhFJ8
         45Vse3mblR+uUMn6tMWl5Odsfk2aOVTQ/Nar5QHsjTE3aU7OBwVlXyMXOj2D/BB5ss/c
         WEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793352416; x=1793957216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7q+/4+4zxMUP673wzD4KRVvcydFuIy84hUuAGiF6LM=;
        b=s5J6nocZyEZglLdL2kmnLIqWQ1S/sQRv/Aws6aYExfFl5E6jtK6ibBOD2vNqILlX5K
         bpiILRReZbcUt94S0jVkZ7uFQ02lJ2a5cNta74N4xxKxah3uJBoc6lodNr+WFoQOK8dm
         Xdq8qgu8ucmm9XVLeH+AsN+eJNaVfFS/CSiGNIjb5relAlP/xxAaDgKVLVUKobLxWfXp
         nZz2EATq3uzZ7TSjCK+6By7S9RJPkcSS3C8OacCgmVF8k0qv+U2yqCGDwlONTY9YCtwD
         a7qG6Usls2OwldnNvNPnV4RJZOEgHiJLaDzvB+yHtRLF0UDPz/SLjRYwJMx5eCnd83Im
         5pUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMTPRafdeyCnABf8o9orHTjs6ljblB70lTlNc9ELpdewnluxcZw0Xo0YiPbzWH23dgiexAovUQz5Cht5ok@vger.kernel.org
X-Gm-Message-State: AFq9FYJjczh2a4CsUuWmgsyPTGaafkiodv801bSm0fJ1cRII2AKgJBOU
	02AqDTe2ouHb+Usq+7+LHeZ7JfU4FSyJ3LEMhytvtBdFg9Qg0PWEa3zM4rEuV/2yeGAsecuiu+U
	rY0O8KP/1hDWvQlkGhvl2QP9eTWSsV5U=
X-Gm-Gg: AYBFou1s+PCgG4zxR4Dz/C6krem92VVidcdZja7sIHGHQhC7oF+pXU8rng7F5ZEhsgN
	5QW8/pHNTbAhd7KRTOwMpsO2Uk+PbVZIFJNnD8i5HWD7l2SZKcRoR0zAxlH5W7c4Dg6feQ2RAq9
	kMg5uuzVhF7tLsUtiRyg0LLXCoRfYdmB+pSFdD1ILGHdvR/BXyAgVDvEfHcqC1985BMw5lwVH56
	+3lXgMS812nFGRNVvoc0qielvOrdixaARr/DdxFdTQPD4Y2LOJHbCcAvQJLPmpeL4z/8/Z7lL3P
	rZAmv/h70JlRFlHdRwm89rxBiyZrgs3g/4OMOIa4MUQPFTrq9IetmT3UmUmzVBktDaIrvSynNeR
	uy5m06BuSFFECxeb7RACV6cFvL8jUajbuOj2VkKhC7XOVjA6LSsR4Fik5KnB/gQRj6GiM9w==
X-Received: by 2002:a17:907:72c8:b0:c41:c106:9772 with SMTP id
 a640c23a62f3a-c4ca792f071mr151923666b.1.1793352415540; Fri, 30 Oct 2026
 02:26:55 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <P58Wrer--F-9@tuta.io>
In-Reply-To: <P58Wrer--F-9@tuta.io>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Oct 2026 10:26:44 +0100
X-Gm-Features: AclHuK_RA6XrlgVHuWWMqlPNjOqYiitwMvc6OBqsxoVy-pqo9NlWDMGkDue8iP8
Message-ID: <CAOQ4uxjqa_bTBaScWMfoUvhHL_xSxDQ2xK7+r9YsaWOaXfKC5Q@mail.gmail.com>
Subject: Re: [PATCH v3] fs: let backing files inherit FMODE_NONOTIFY from the
 user file
To: Edvard Conrad <edvard@tuta.io>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 10:18=E2=80=AFPM Edvard Conrad <edvard@tuta.io> wro=
te:
>
> When fanotify reports a permission event, copy_event_to_user() creates
> the event fd with dentry_open_nonotify(), so that the listener's use of
> that fd does not generate further events. If the event's path is on a
> stacked filesystem, the stacked filesystem's ->open() opens the real
> file with backing_file_open(). Since commit ebe559609d78 ("fs: get rid
> of __FMODE_NONOTIFY kludge"), FMODE_NONOTIFY lives in f_mode only and
> the backing file does not inherit it: it is allocated with the default
> fsnotify mode, and fsnotify_open_perm_and_set_mode() raises FS_OPEN_PERM
> on the real path if the backing filesystem has permission event
> watchers.
>
> Before that commit __FMODE_NONOTIFY travelled in f_flags, and overlayfs
> copies the user file's f_flags into the backing open
> (ovl_open_realfile()), so the backing file was exempt implicitly. Commit
> bc2473c90fca ("ovl: enable fsnotify events on underlying real files")
> relied on that when it dropped FMODE_NONOTIFY from OVL_OPEN_FLAGS.
>
> The nested event is queued to the same group, from inside the
> listener's read(2), and can only be answered by another reader thread
> of that group. A listener holding filesystem marks on both the stacked
> and the backing filesystem therefore deadlocks as soon as all of its
> reader threads are inside such a read(2) at the same time, and every
> other task that touches a marked filesystem queues up behind it.
>
> Observed with a commercial anti-malware agent (16 reader threads) on an
> ostree/composefs host: / is an overlayfs whose data layer is the ostree
> object store on the same btrfs that holds /etc and /home, and a
> systemd-sysext overlay sits on /usr. Every on-demand scan of /usr wedged
> the whole machine until the group was killed. Stack of a blocked reader
> thread on 7.2.7:
>
>   fanotify_get_response
>   fanotify_handle_event
>   send_to_group
>   fsnotify
>   __fsnotify_parent
>   do_dentry_open
>   vfs_open
>   backing_file_open
>   ovl_open_realfile [overlay]
>   ovl_open [overlay]
>   do_dentry_open
>   vfs_open
>   backing_file_open
>   ovl_open_realfile [overlay]
>   ovl_open [overlay]
>   do_dentry_open
>   vfs_open
>   dentry_open_nonotify
>   copy_event_to_user
>   fanotify_read
>   vfs_read
>   ksys_read
>
> Userspace cannot avoid this: the backing open happens while the kernel
> builds the fd, before the event is reported, and fid reporting is not
> available for permission event classes.
>
> Make a backing file inherit FMODE_NONOTIFY when the user file it is
> opened for must not generate events. This restores the pre-6.14
> behaviour for the fds that fanotify creates (and for any other
> FMODE_NONOTIFY file), while ordinary opens through a stacked filesystem
> keep generating events on the real path, as intended by bc2473c90fca.
>
> Verified with a self-contained reproducer (private tmpfs lower layers, an
> overlayfs over them, FAN_OPEN_PERM filesystem marks on the overlay and on
> one lower layer, a child opening a file through the overlay) in a qemu
> VM on this tree built with defconfig plus OVERLAY_FS, FANOTIFY and
> FANOTIFY_ACCESS_PERMISSIONS: without this patch the listener's read(2)
> never returns and the child's open is released only by the listener's
> death; with it read(2) returns, the event is answered and the open
> completes.
>
> backing_tmpfile_open() is left alone: its only caller is
> ovl_create_tmpfile(), whose user file is a regular overlayfs file.
>
> Fixes: ebe559609d78 ("fs: get rid of __FMODE_NONOTIFY kludge")
> Cc: stable@vger.kernel.org
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Edvard Conrad <edvard@tuta.io>
> ---
> v3:
> - Back to the v1 change in backing_file_open(). The init_file()
>   variant posted as v2 was larger without being more general; Amir
>   withdrew that suggestion and reviewed v1 instead.

Apologies for the detour

> - Add Amir's Reviewed-by. Drop the Assisted-by and Suggested-by
>   trailers and the blank line in the trailer block, as asked.
> - Keep the subject line from v2, which is the prefix used for
>   fs/backing-file.c.
> - The reproducer posted inline with v1 is now an LTP test, under
>   review as syscalls/fanotify26:
>   https://lore.kernel.org/ltp/P50G-yE--F-9@tuta.io/

Thanks for following up on that!
Amir.

>
> v2: https://lore.kernel.org/all/P4wV1J9--F-9@tuta.io/
> v1: https://lore.kernel.org/all/P4sl5iz--F-9@tuta.io/
>
> Tool disclosure (Documentation/process/generated-content.rst): the
> stack analysis, the git-history search for the regressing commit, the
> patch text, the commit message and the reproducer were produced with
> an AI coding assistant (Anthropic Claude Code) under my direction over
> interactive sessions; I reviewed, built and tested the result. No
> static analysis tools beyond checkpatch were used.
>
>  fs/backing-file.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 5614cb7801e..24357bf9328 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -43,6 +43,17 @@ struct file *backing_file_open(const struct file *user=
_file, int flags,
>         if (IS_ERR(f))
>                 return f;
>
> +       /*
> +        * A user file that must not generate fsnotify events (e.g. the f=
d
> +        * that fanotify creates for a permission event with
> +        * dentry_open_nonotify()) must not generate them through its bac=
king
> +        * file either. Otherwise a listener watching the backing filesys=
tem
> +        * gets a nested permission event from its own read(2), which onl=
y
> +        * another reader of the same group can answer.
> +        */
> +       if (FMODE_FSNOTIFY_NONE(user_file->f_mode))
> +               file_set_fsnotify_mode(f, FMODE_NONOTIFY);
> +
>         path_get(user_path);
>         backing_file_set_user_path(f, user_path);
>         error =3D vfs_open(real_path, f);
> --
> 2.56.0
>
