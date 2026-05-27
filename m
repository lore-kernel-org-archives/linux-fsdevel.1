Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9F313520
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915205; cv=pass; b=IJUqQbzLG95M4+OZSjT+rZaIwbk2YhG5PxURk2Xq9az5A3quoGSHeIJVkV6sW0ZeNI2KYGILXBJnXUComk54BU5677O+jPpKQ8iz00V8Cr2lYyNs+k6+kdQV+kC50iPZXEPEE9gKiD/LSaQjIQDvASyIkRgbITKqzdXB7fhrPoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915205; c=relaxed/simple;
	bh=wmy93l+/aBdJc9H+704sJw9+4dGAbErOrmAMS1b8xyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtmVcScWS7l2dORZXb7CPB1XD5NjUMGr6CxkcATwQHk84QMHgNYyarkeZDC1yl1uLQCU5rW2JlRGUV/WDEeE2daBk24rIxtjEuNq8gZF0U3eAMC++pBMU3glwaleukxjsLKVJzeX4RXnpvFT9mPtzUvnJDPhmF1HuFj5E+z2OZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUenSyuh; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUenSyuh"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so7412702f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 13:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779915202; cv=none;
        d=google.com; s=arc-20240605;
        b=ExU8QHVd5QM/BFN905ePDkFm6lMd1rlDvjS0v+H/ZxlqzVoxsW/UfGvRAhDG+p13ov
         XJv3q18wQBUY6xjT449pPPYCJKFOqR6mRbomvNAPWWQVKUCMdOMynD2pPEdIs1Hf65pM
         1MX4XemzYBvPGIoRwO/U0bK+JiRiPEOL81TyeKr695HAnV09VFf78vLA9rQJqdMRv3b3
         6+f8bqcJjF3n72AFQuX5BU8Nsf7ziiwhgA7NcYC3vs/BpULHdqQ16aH0nLPbmXgM2mNi
         JkmVGrghkEqjSqGd7WELRrI5GMuI8r6yC9dOL/POcXvJ/LZfE14070ndmAhcueT+zGbB
         U+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wmy93l+/aBdJc9H+704sJw9+4dGAbErOrmAMS1b8xyg=;
        fh=S3+1IlfpX7nLyuOf5UQpkwmE2kfEaftBf4CK+LGcLv0=;
        b=dUSYJmlmEde48UOhMe28drstS8pdry7lLTGp1W6+uK1hRLo4oKv0rie2dmTT7GcfBj
         s8FD6+zSNbI14hWLZuwyJ0eCzcHv402Mi4E5uYzIX84vc+KYhYwy5cJ4qWJoZDLjDDYf
         zdKM/lfYmmI0lu8ihTtcC3182iSmhzvYo3svBcCG7xCbiLz2rCf1f2Xe9Fq1qPPECg82
         b1mMUeLDIqNK9HZx6Yilg6JZ/iLNY2vY+ImC2hSTAak20nssV7zUJxGyDGEDgxBixTMx
         nEhy6nQptgDGrIGha8MDQkb2zLp4nkag3/chxkr5/kMy0ZIprmSUyHknX85uuwZT+DFV
         QjaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779915202; x=1780520002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmy93l+/aBdJc9H+704sJw9+4dGAbErOrmAMS1b8xyg=;
        b=FUenSyuhraXSgwGWz+MioPzRp8kACsP/s9dVA8AhMDnVM567UYXHmPWqGOj1oLmAys
         UUApcxtSsqWzdJf7V0XnbnXMWcLXJI/wuWLezSlHlPZlio/EvhgDt5f+3yzz2hLuCHaK
         ipMxDDuPx1M9mC5by9xJWUU5b7riQcCNwzk7S4B+JFMPc7cUGHgnOGjIXnXDghEOBCL9
         T871cNMQN+9s2BPwiU2eDY1amZ1it1+Uj2yUYK2uY809gWGMQ4kmytJp1BcWu/M98NCh
         tagavwlpHllFRrY6ujJ0SaaYr3ituKUz5/kQDfIMJ6wLqJ08hls/8kPOmv1pR8l1SdPr
         jw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779915202; x=1780520002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wmy93l+/aBdJc9H+704sJw9+4dGAbErOrmAMS1b8xyg=;
        b=bC9Yami2SaFHf0tW2GRlhvnrKWc9Ws+cZ2g2GRc4js3KwUcblaEmhwLVSiqpi5yg26
         tN01baQcQfH5Eitly54kQZqxjmYbvcPRKNOAE+zOaS9bUmygBTsAMxwLq9PVTU8gBkuG
         l0kTDMX8wqnSTfc2R+ZxEAmqP9GvvT5yr7u7VxnWnhm6Hf/BoaG1AWt3cTQLQN/7qEnl
         9yuA4awNOlP+O4J6jMCd8ROHxH/tnKhXnr0V5JPI1xQN+N2uYJ7c5RjRfCmjGIE/lpE/
         Yey830Oe1OO9xa2aKdmhav5nDsuW2XProzTecvFLh7cGGMH643F4/izhu++stddsuuxJ
         tUng==
X-Forwarded-Encrypted: i=1; AFNElJ+O68HtS+0uh7oEUYErdchK4+HTwu2aSXmU+Ni3RgjLacykh7nNFFA2QbTjmBHcNyu6SZHIKAS/Rq4Ducat@vger.kernel.org
X-Gm-Message-State: AOJu0YzJlmmadjvqopxXZLEKh8oEfL8vTNmTJ3MRt7FP1GSuhTJjyDD/
	7nYIhj6JMXs/LFeskqgJminR6c1hQl0/IeHT7UD3rVk9zBi4QDzb5vb1offd7EutTFTPHGOtkI/
	yMgI4e63c3q6upZrtXl2Odgh0D9TJ2jQneM0nm0g=
X-Gm-Gg: Acq92OGUAEVfKn9JHTMiBbdrasY9vIB8kRNfzrQ4ziE/tMK/Ln6BYiedq3O7BywfPnn
	JpF5lxgeMSQ1uzUz0672AHReLLwQ6rpz36rar/7OJLCJU8ZpDF5jD4WYFsQCYBWJwsia1o0N1zL
	jzsR662tr7fHYJm2btprVWD+8wemywCavLtezqt9todj6/5VAGcLKBKLmnST6QgJbmEgMagAfGS
	ApscR/jJ5P3MMJKXysawLppfJU+QFIdZv/UtCuems1oV2JBlQn5qhIi3e8+Vvv5YImyB2nnz62y
	dS47u/IhlJ++lIokF1RT/kMoaMtz+/u5hQ==
X-Received: by 2002:a05:600c:4510:b0:48f:e230:72fc with SMTP id
 5b1f17b1804b1-490428ee268mr384790785e9.33.1779915202084; Wed, 27 May 2026
 13:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-2-joannelkoong@gmail.com> <ae5355a5-b10d-47e2-88f8-fc3eaa0de54e@linux.alibaba.com>
In-Reply-To: <ae5355a5-b10d-47e2-88f8-fc3eaa0de54e@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 27 May 2026 13:53:09 -0700
X-Gm-Features: AVHnY4Il3qkvk6D6gZbDOw1w2l5UyCEreQgdw11d2LS3_hgS4aWwLUlJ_NYAIk0
Message-ID: <CAJnrk1Ypd=ek1E7qLpdxCoVzwzmzXLktXdpDbjPBZz7qKrWWTQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] fuse: separate next request fetching from
 sending logic
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, axboe@kernel.dk, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 9:02=E2=80=AFPM Baokun Li <libaokun@linux.alibaba.c=
om> wrote:
>
> On 2026/4/3 00:28, Joanne Koong wrote:
> > Simplify the logic for fetching + sending off the next request.
> >
> > This gets rid of fuse_uring_send_next_to_ring() which contained
> > duplicated logic from fuse_uring_send(). This decouples request fetchin=
g
> > from the send operation, which makes the control flow clearer and
> > reduces unnecessary parameter passing.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Bernd Schubert <bschubert@ddn.com>
>
>
> Nice cleanup.
>
> Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
>

Thanks for taking the time to review the patches in this series,
Baokun. There is a newer v3 version of this series in [1] that was
cc'ed only to the new fuse-devel mailing list (with fs-devel dropped
since the patches are only fuse-specific). I'll make sure your
Reviewed-bys get added to the series.

Thanks,
Joanne

[1] https://lore.kernel.org/fuse-devel/20260522205823.1597313-1-joannelkoon=
g@gmail.com/
