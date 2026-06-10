Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DB9409611
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098157; cv=pass; b=fjH2HOwEdctNn6ycN4maWwfzG6E7/dC+wWf6io/cYHYgW6A7LaW3GwVR5CCwEWQpIACYBXpl7p4nnv2nqxz4oqYuC8l8FrGkxYKKEsHb1S+Ja0VlIC2qe6w6qVkDmhiGecGqHYxfodBJrnuEJJzobzp6BpCCZR3cRwZFDQ21QfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098157; c=relaxed/simple;
	bh=J+malEbfLZAyYmT+MJed3IJxO0vMsPQ6ALHa3I8w1qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZRE3yK5FvU1CuVZY609uPbiKHYRjJVb+pCXCIixUu1h8YzeaWeikZXVR+SrK4h8GJvdZ/m5c9pU84clP6ktAh6/gJgqTu/Nzmnc5MJKoluQLEgMp7+TO6QEm2vY+uJVSz5IuiHUeGt05EuqE6/phQ5ddpiztwciHNui+Ll2abM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gfd57eXn; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gfd57eXn"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51780bbc560so58075371cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 06:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781098154; cv=none;
        d=google.com; s=arc-20240605;
        b=kS+5e23Js83KcrhUPwoEj08wp+VPXxDoRttMWjR20zZwMEGU1wRwJ7oexQQHjQ2bt3
         CiRa1hcR/sr0fcnWN6JwucPzKNBq+Bqx/FVUD/UuuAe0CL4Gr+Sy60/RAtOklJo8l87F
         kZA+SD8A0Hm4FVyHOewp/QubY1GO62Hr+3ma/Dfuvz/OyfqNGIbiKGuqoVS8ICWc7kOD
         2ARmOk0cgb9aUBBnbdBqTp2ZGLoBLkGVqeJqEUb0XqvTCCWR7r0Tn0kCl4m+DosjiiNL
         KujDZhrBB/PIRXBjyrZwKY0UJDHTRVVo0fkVTHKyVkPTmm4dQPkAEGW0QWvioJCDACNG
         sVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SNLqVn9ZS781YXdAhD6QvOOrHfuXhzpRyQc3CU+ZXkE=;
        fh=ukApuRBb2Ff+ncFfCEsj9PE5s4Q3ks/Z2tJBAwawBhU=;
        b=ZtaROemMUmWX38SrfiBVmjgS2dYQ3bwb+g6NPEwRfywriSZ1VcEFp4ASF5kKr63YlJ
         tBoulSEKom/29QAsXrGQ3PNSkkxZWsb3qbak2qegHP6qjA18bvwSC3vus3XQwZKPaJSs
         yZiQDtHd8IxlfTEZ2Y+2Z4ny2lhWg0nz3hariwuutpGb2xj6d4/rF4FPU38POj0sb90l
         xl0Olm9FN5oLEvc45N7cBc/ExYQNJmaKaB0ZSABBGeKnScqZ+F5qpoCAFIKHV5tztRmP
         2JyWZkA8zBEt+A3l/1q5WJ700lyLx2l9pAXcbJQFWPYhwRn5ZkBYON5eSURtfWoLPUlS
         yGIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781098154; x=1781702954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SNLqVn9ZS781YXdAhD6QvOOrHfuXhzpRyQc3CU+ZXkE=;
        b=gfd57eXnY1gniELOOhYlrG34QKl7KOFRSl/Um5he+Mok1vV80mi82CENnrTwp613n9
         K4VRvOFLt7VrDxOCXhzRVI6M41RAuEDT4BskhFeyRIRcuZw/+5QF2gfy5EQO66Z8Nkik
         AVEmvqppfm8YQibcpwKGDTUULz1CyJb3v7qtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098154; x=1781702954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNLqVn9ZS781YXdAhD6QvOOrHfuXhzpRyQc3CU+ZXkE=;
        b=qqHXUcoV3OWm27JPHhmXzB118mEseYg54tbdgCavZDQLdGNGLhWx/A4/BdAytX9C6X
         tSxnHdxNFahwZKp9pfdpbWAWfHnlYQefnel4tCwxRgXCXZhNH4bpvTOn58+j0J20Fzdg
         kkUAfCn/e0cIORI+ofyzRSy/CwyVHe/rl5KdscsWc4BzJhx/0N2b8Yf6RizksoGktAJe
         5VUM/jqFZE3BVTq9NwTWKLB6EhZLDxRLijc0a/hWE3388TmzJEdEKNk2PCrqL8OEUBxb
         k/k3P9K39aq79ScdXo4A3f5/n7mmVr7Q99cZBzZLleV7ZrTlSlvDRLMGSyiFWdHkliJD
         qTVg==
X-Forwarded-Encrypted: i=1; AFNElJ/2LxYfTNVRwgOf6Ig2sH39pkWkxEOQ/68QRrW3ysgn5qJ1T4YuClImexBkkKvsIvjhepiBMYidWJk5GjRt@vger.kernel.org
X-Gm-Message-State: AOJu0YztwKAlU4QfhN8wQno1mc/wLkpxaDYlLLzH/xzf25YNWKLLCiVq
	jQ+ZMu6TGfHHPxFf0zqjbYJFv1MLKPl/7HCUBVFf/iruWpKekrlIB6GK52RhrZifDGiZ/N4DqGy
	Ux8OMz7KLckZLxxPcKG6ugIw7GnWFugdeqwLKXI+nxA==
X-Gm-Gg: Acq92OEOku0WA/lnBU8oX1tFLAVmoaB2qIVzqvPHca8XxtORgUG9bApuwo82f5CD9sq
	ZNPP0mVege9aLo1PK59IyHrgYv39sTWUTLGRhisG+VWO0Oby74MMma/zjVs2eeDvPP2thGAr4MV
	hCrQtylADU/MmqF8TAEAmagCV3vwzVg0eIA/TpGEea4OLcoJp+Bqw01k53PsAVnBEnqwg4vK1zD
	J93B0pNTa46WszE9R6p+TkgFEmQQQnmCByjNW5geQStno8uYgjWueYgdDek3KJULTUKDxBN9WvO
	pWL17ENxVQI/nfi4PEMFseF9EjKLeFeV9NjZprhr1QgMOkr+0vss/PUAas8ZBw==
X-Received: by 2002:a05:622a:244:b0:50b:3249:828f with SMTP id
 d75a77b69052e-5179888bf1dmr247350811cf.28.1781098154423; Wed, 10 Jun 2026
 06:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522083805.569007-1-liwang@kylinos.cn>
In-Reply-To: <20260522083805.569007-1-liwang@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jun 2026 15:29:03 +0200
X-Gm-Features: AVVi8Cdu8c8832XfxiTEKSnJxkEiZTaVZWUYQgmqg0KDSHzu84GS5Gq2hYrkWNA
Message-ID: <CAJfpegsn446b3VCbR8jYUBpX_o4qbF1PqivkkERtTSzzKxFncA@mail.gmail.com>
Subject: Re: [PATCH] fuse: use READ_ONCE in fuse_chan_num_background()
To: Li Wang <liwang@kylinos.cn>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 10:38, Li Wang <liwang@kylinos.cn> wrote:
>
> fuse_chan_num_background() is called without holding fch->bg_lock (for
> example from fuse_writepages() to compare against fc->congestion_threshold),
> while fch->num_background is updated under bg_lock in dev.c and dev_uring.c.
> This is the same locked-write/lockless-read pattern already used for
> max_background in fuse_chan_max_background().
>
> Use READ_ONCE() on the read side so that:
>
> - The compiler does not cache or coalesce loads of a value that may change
>   concurrently on another CPU.
> - Prevent KCSAN from reporting an unexpected race.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>

Applied, thanks.

Miklos
