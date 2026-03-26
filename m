Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6439EF2D
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553600; cv=pass; b=aCyOkBU6jPDjOVJ4yw0lPPCzgdGPsNCLomV8WyuEn5P0NMxoeKZVLymg/pMKGQoXfOlBVXmj+FbQ8PFSI703zSWlCVH6Ns7JuLyjYVFM+iqxalDra0BUn0dJTwg6UyllYvfBYTINY52vkqurAXPDSt9ACEOBBE/mu/rzkz18Ixw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553600; c=relaxed/simple;
	bh=XGIkITr18YRht3P80h9kmZoQ7SS32tZiWRhyFaczp1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InURKtGJHzg3xvcwga6anxEkBkk/keh1KM4Mt/2lifGLNYNWYEfxYnpkSwAOhRPghzWbLIUEIApklCqZFD+Wl/wG9Sr70qiS/vWInitjHEm4RVqgQilI5Q84LB4cfEJDQNOIDlKn7GnJf2vL9TILIPEaUag4sh/9WWg3RTszE/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LkdroYlw; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LkdroYlw"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66a8242c1d8so2594a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 12:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774553597; cv=none;
        d=google.com; s=arc-20240605;
        b=aIA7r9M6kkCoJ+8e8CroAuYh2OM5OK+iTBiaQdwEsbd9bsxVYbBMIFe7dRrX9ytgKX
         324912grbd7rNKLetXWnt/4tMDpp/Oxb54zGzGQfA8o3ZIg77xG+/M1IlW9XZvGv1Ixi
         yDklaqBbfMeyjxJm3r5eyp6QuwK+EA5gm9OJUhmHzAiG4lU3SdSJL8V239o9rIBt3J3C
         MAOZIKXJlCqKtiyxBGxLdUWoyK444haQ3ztUjXUI4uBUuo7V7oGmg30niT2YFM3lUlvP
         HSJIATVn0x9kiuczUIf/TPyinKGBHqbaj3phm64CzB8qSwanqGITP+q0qzJ1gYEOYRwm
         L06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i0YYIrvHnBTLeQ6iT3Vhfn1kaGtvbxQ898sn+jDwG2o=;
        fh=3WDTXw+5sHlG86prA/WPVpSwpkPhzHeGdCiXnFD613M=;
        b=e4xynpbQyz0Pce2AJUIQfNPQwGnwuJtuMMjQ572Zu0IiEsVvRFWHhV+bFaYP8ax0r6
         sNApril2MvPlkpl6zFGC0RTmZcEyRCqGmiFRtaq7elGjlNz/kypmi39/UYU9keTHFIGO
         0nBCXcmi4RzN4GqBk+QL8uGEyYePdbh8YpvOTEtju0+HApEQFb3jw7BNhTUulbE+to8e
         qcdmOSGLSaOixtPbzM/mA+uRlT8lIiet80fIbfg0HGaWu6+yEzFflTSm/fvEofGeW6jl
         TGXnADA1+cjsCkt9XxFeq7gMMnza1ruT0tD7bKVfbhy31cTJIvSzKYJDJ657ZV1zK30z
         riZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774553597; x=1775158397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0YYIrvHnBTLeQ6iT3Vhfn1kaGtvbxQ898sn+jDwG2o=;
        b=LkdroYlwmNyNc112hm8cLn0jT9UjNXFknsKEqf1hPo6WBik/MI8l9J89RQtzX2M795
         DU8oTOXxVeXejWRfPk7q09thkC26WRGEIH/x/EHd6VFdvuWPNJpKLc8/1ruvQiPjS8+r
         XLo+umGYiN0ihUSSEMSIIYY1ykesNxWDAJuR+7H/566eAibZvJrZKgpekOXyaIrapa/f
         3xrbufMymx6CYMvEHrI68V5SiL9UIyxZwaAnVzD3CX7W6fa1DKcmBbjsoRP/h6zCiihP
         T/3iYZiUzRHNrr5ClY5o7T/VcqLdw+5/lhX1sULydiyaAGAa1AOSolPODFdYkUCPDyoX
         NLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774553597; x=1775158397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i0YYIrvHnBTLeQ6iT3Vhfn1kaGtvbxQ898sn+jDwG2o=;
        b=dMGOz0ScDCIKC6u7HUZiwre4UEmQW9uuoLHUwGLtGUfHtkyMPBJu0nmO4/7kmX2dnN
         jn+xB6TK/hnD5TiB8/giepuIFtI9ExIDYFSVQPIdBmnVvm/qh/8uoL53Ta5dUBS36WFg
         ElcV1BUA8FzHJZKV7POOH0QvLVYE90Tb3xqbg/roCemE7V0949KLtxDLp7YDNAC5K80P
         SZqo8dsmhRa9bhwYL1GjQnejsvhQE3gLkkRLMILeJFsYDneq3HUXVJehlXHdTGu2e7IG
         ZuGrdWmnVSXzFWZ+Yzm+ZHJ1x9Pa5t7CvwBv+E9ssL+tjOKsuOXEytt5pdTeyoXAI55W
         91AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy3D/FdcSIIutg0g0BSbvSrC/oM+CobL3rCuKdx5MudWo/s3LWKIxdWn2tTvfB1c8F+sCNJ8XbuplpzuRO@vger.kernel.org
X-Gm-Message-State: AOJu0YymObqzj5dnSfI4ZK84/nCyi/D/zShVCTBDEXloogsOClxqq/QN
	HDe9yBEBREMKuh9UvoRmGdHzYli5z8jwsKBLlNLR5w1w5uqDuf/EZckTdKS6HDpkG4pPydGc+oe
	/OzcCEDQ5ra6vF/LcAWO1URmSip8McBuujKglRDje
X-Gm-Gg: ATEYQzwG7PEbuZKesvquAqhlpXRC0UoYt+V/pg+ybTq+l/dCSrmq1YOvAOqyOsWogT7
	2TQyxu3YWMLfpeduagRWcxAyaTqUbSe328ek6f2Fz8Ti3qPnWKujBFP+BgtsldPi91MauZAwwC6
	KA15iF6iIWAWmzH4IrT9ak10lNUBLl3K+D9VZ8SuCt8OIA17EJCTKtEPHGdZyuzE483RE0h8p/p
	tI5Q7Cj6ww5MwSAwWmDid+f+bWQgIC7VG7SwaJB1rv0zP7LUJ+TmfH8Ay1bjkfHpX6bPE0x0GAt
	enNmLL+HVrO9b8wKgsc/O1ysdVDBY8Ac4laX
X-Received: by 2002:a05:6402:3054:20b0:665:d39:4b18 with SMTP id
 4fb4d7f45d1cf-66b19dbc821mr9214a12.8.1774553597067; Thu, 26 Mar 2026 12:33:17
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306003224.3620942-1-joannelkoong@gmail.com>
In-Reply-To: <20260306003224.3620942-1-joannelkoong@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 26 Mar 2026 20:32:40 +0100
X-Gm-Features: AQROBzAqizh2z5m9_5qLH-WZQAEv4v5co6vK-W8Njl6U5WEXvbdoBACM9aVLgiU
Message-ID: <CAG48ez0H_Z-NQvfOeczECz_sO=MzVDvu+8m+msB55rcAPfQOgQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] io_uring: add kernel-managed buffer rings
To: Joanne Koong <joannelkoong@gmail.com>
Cc: axboe@kernel.dk, hch@infradead.org, asml.silence@gmail.com, 
	bernd@bsbernd.com, csander@purestorage.com, krisman@suse.de, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 1:32=E2=80=AFAM Joanne Koong <joannelkoong@gmail.com=
> wrote:
> Currently, io_uring buffer rings require the application to allocate and
> manage the backing buffers. This series introduces buffer rings where the
> kernel allocates and manages the buffers on behalf of the application. Fr=
om
> the uapi side, this goes through the pbuf ring interface, through the
> IOU_PBUF_RING_KERNEL_MANAGED flag.
>
> There was a long discussion with Pavel on v1 [1] regarding the design. Th=
e
> alternatives were to have the buffers allocated and registered through a
> memory region or through the registered buffers interface and have fuse
> implement ring buffer logic internally outside of io-uring. However, beca=
use
> the buffers need to be contiguous for DMA and some high-performance fuse
> servers may need non-fuse io-uring requests to use the buffer ring direct=
ly,
> v3 keeps the design.

I'm looking at the next-20260324 tree and trying to understand what
happens if normal userspace (without FUSE) tries to use
IOBL_KERNEL_MANAGED.

For a buffer list with IOBL_KERNEL_MANAGED, io_ring_buffer_select()
will write a kernel pointer into sel.kaddr, but nothing in this series
seems to ever read out of sel.kaddr; that only happens in
fuse_uring_select_buffer() in the FUSE series
(https://github.com/joannekoong/linux/commit/fae19be22ab629b1301f37f2a942d5=
d84b45cc5c).

Instead, looking at the reverse call graph of io_ring_buffer_select():

io_ring_buffer_select
  io_buffer_select
    io_recvmsg
    io_recv_buf_select
    __io_import_rw_buffer

 - io_recvmsg() passes sel.addr into iov_iter_ubuf(), which creates an ITER=
_UBUF
 - io_recv_buf_select() passes sel.addr into import_ubuf(), which does
an access_ok() check before creating an ITER_UBUF
 - __io_import_rw_buffer() also passes sel.addr into import_ubuf()

I think that means io_recv_buf_select() and __io_import_rw_buffer()
will first access the union through the wrong member, then fail on
access_ok().
io_recvmsg() will create an ITER_UBUF pointing to kernel memory (which
AFAIK isn't supposed to happen?), which I think will then cause a
later failure when you actually try to access the iterator (because
copy_to_user_iter() checks access_ok()).

Am I missing something that prevents normal io_uring operations from
grabbing IOBL_KERNEL_MANAGED buffers and accessing the wrong union
member?
