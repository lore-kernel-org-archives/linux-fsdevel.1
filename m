Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5423C872C
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788383291; cv=pass; b=YlpJoddclexdWWjpvf27hIUxti/lEy4cnNybT5toPEA6R55JKUYq+UXFLqJcOx7zWkpkzM1KftZVLM1+363ECLs4A97z1lOXs2Kdc+GwCrq6vRJqFB5dGRyOtmU96mFf73aKbpa3l6MdjSlNxnbNPxXaCyi10VLPpe9oBiOXAjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788383291; c=relaxed/simple;
	bh=UN1N4GaOPeTmD6Z07qcHfiRUT1OJYE5x12PsUkTyt3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwMpputmFEj7/g2kbP2+7eKBy2DdWB0mDULPWJABYuKty8t2APeY4smEu0lj8fiXPEVXvGfDLVHKUuA2azN4L6u9lIWcbXmca3hzQnA2fjjQQHiA7eCzmPeElgW32+I8hCc+Z/JLjolsf8SjX1QKndtCCcSQgROKvnYhNcHz+2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fasheh.com; spf=none smtp.mailfrom=fasheh.com; dkim=pass (2048-bit key) header.d=fasheh.com header.i=@fasheh.com header.b=IahtgZsm; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fasheh.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fasheh.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fasheh.com header.i=@fasheh.com header.b="IahtgZsm"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90e7d9c747eso19510956d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 14:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788383285; cv=none;
        d=google.com; s=arc-20260327;
        b=FBtzmyRRTsgFTk48rtuKCwOSuv1SpHH5od95g4rj/Uvu3AGU4RoRIfmru6oGNg6NdK
         Xfk3RVxwC/f28koxFT/fmWJK/kbR4rOeJk2+rZNbHarcFk9KrcdoX24x75X/l9gkO2uR
         kjuvT1xaW/IyVwLq+on3BM1oDCK0TsPnOnbWH2ULtG9D26vwJmcLYdG+wAaQlHF23SB4
         /g9KLmFuNxvi2e0Knr3hQ1Kj2fgAlStYziz8u8GkHDEqgLTPO8HJthRHB2j2yjFSne8N
         rYO2uQl5ZqEK8YKiVJMP3DS2btFl3ddaF1irN5NRhROse5P63ABp2Trkp609QmL6Cufs
         Yytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UN1N4GaOPeTmD6Z07qcHfiRUT1OJYE5x12PsUkTyt3Q=;
        fh=JFPNdS/3IqAMEpD/ucEcEaFeDA2CrNBbKh1GqWFVPYE=;
        b=JGtDjKfklh1cvrN41I2IR5683w/qANDJ/WyIN71DGE76MbhPfz2CpbKrxKwLLxthxF
         SsyDbZOdSAf7XhTNkqQZQ7Zu/CF10zfSuYHi6O0aekr7PZW+AdnwcZi7wBXm/9D85oph
         YWMMXtBVlq26nxI2gmygZZ9wfHRx1M5AZ2rGh9ZEOykuqlFPGLH0xEeAC79bNXGMZVK1
         5tR7gHS1oeFFexvXwYYzKhpSjIFOwZn3qnYymbq6U7WFgw37CKnnTxLNmyLLhXRS2a/N
         OY3HuPxMVm85LfGSu03dFdge0d+8qHetlGnXyhN3qBAi5Kp1ZY4JeL98bikn6Nm8/MA4
         wSyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fasheh.com; s=google; t=1788383285; x=1788988085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UN1N4GaOPeTmD6Z07qcHfiRUT1OJYE5x12PsUkTyt3Q=;
        b=IahtgZsmdL8wjEqra036j4tkHcj+IdoFoHjh+uS6qwYFOoyTKsR4kv/+Vika+ayFEn
         Q9D5aCxxNuHccYq+4VmzASV6XkBRhk7VxNkIXcAPzSeI9H0VE6ynucm9UcPbJXi3fPOR
         A94bKYT6wn+tzVuE+f1bmvNI+sEz9mmq76YW5cvaITlhvG1wCa6QhUKb7cLBDwpTFWVH
         GQJMyZd96bKEfA7eXA04LCut6OXuxoz9/mx2Z0pZrUX4HxgO10QRt2bW0RrlyKJ2I9uc
         /Q+CeDAlNrjyqcfmVFy8AbBjvYUGgFK2owjOCSdVzmxImYh21AmnZ3dqGfGAGE9UduNC
         bs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788383285; x=1788988085;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UN1N4GaOPeTmD6Z07qcHfiRUT1OJYE5x12PsUkTyt3Q=;
        b=olgizQfcdeW7jSZN4Q3p+6psI6Yb5vkh5XMSCAdfLGoN4aavQz7FD5uBO6cfu6QmzA
         Beqi2CkI9TTAMqcjtqSrZNu9h4BefKyAVTIciIFdpyRa9F48YUdWerCFFYpBDCDrTEE8
         nlXngxI0xDvdyJiKctrz0JJ4Jq6xTLsoaaEEMwhuCwwCffJoNfZhe53NRBVRImJLhRcG
         hzfn5SrgHSdSnFbTEInGZyZq8mQmBNlVcEwkyL0pOhnkR0BpX1nX3J3OprtoDpuuppeg
         UfLABXdmINsu+cjq7rMQ5VyxN+CsVsZoO1aPl7jkQ+6Zb4BfjkXlLPzh3vyDtIRW+GaC
         7jvw==
X-Gm-Message-State: AFuF++l0c2vlrlh6sWTDXGWmsEavon1rCmQoj+I4hEljzQGXvkVzObfy
	rXs99WWgQkLjjFJ7YuPH5IlRbBvSwre3W1nRdBgstV+geMn9sD2wIGyf1583S05dWyCEic0xiVb
	oKnnAZnj6BJL9LFrmFzVWEmS5pYCXxOQF014txw5IEA==
X-Gm-Gg: AYBFou0waOP60Og0V2pvY/fzpaDPBH4lQHYeCUvW/2WsHjoWUNb66lk867rE0RMoy6e
	vXYIHHOTz9YkvhsIUDNoA5Nt/HbNBv5dTtxbzbh3dEptSuGGCHgDJiVSPw+/SRrTty9xEN7eWs+
	6Up/QWTREdMUgNlAAbPqFcbCHVdvE3Ob+XezNn5MC+nOHwmIdrnt8n3Cv+7QKVLm62SYhJUPM+y
	C9gcWH2q8mdcRuu936/K0uh5H/ibZsciDfRWYLlkNrmgY5LuIt8nf1jzIv8Z3yYkHT4mOrF3ntw
	rX4FUzeL59HCRHtm/aewH/zelY2k8lG8W9hEgv+cak7nnfaS6pSbJBJhVnYRfnkPpwgvVFbYl0Z
	wRC3tNCH9G7k=
X-Received: by 2002:a05:620a:a489:b0:938:fd23:1e29 with SMTP id
 af79cd13be357-93960cb95e6mr829447085a.4.1788383284982; Wed, 02 Sep 2026
 14:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902132458.23590-1-jack@suse.cz> <20260902133702.1313635-3-jack@suse.cz>
In-Reply-To: <20260902133702.1313635-3-jack@suse.cz>
From: Mark Fasheh <mark@fasheh.com>
Date: Wed, 2 Sep 2026 14:07:53 -0700
X-Gm-Features: AcwNN1WtV1dqVx49J7eUpu1wKtIk7R3uNrgG2lJ_B3RcbI_Kpq3v_hSHulQC3gM
Message-ID: <CAGe7X7kgULLGViiEt1o+F32eU7cR9-vTvc3YGJXSg9Wjxa2Sqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ocfs2: Refuse to enable ocfs2 format for another filesystem
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	ocfs2-devel@lists.linux.dev, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Farhad Alemi <farhad.alemi@berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:26=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> It is possible to issue Q_QUOTAON quotactl(2) e.g. for ext4 filesystem
> requesting to enable quota using ocfs2 quota format. With suitable
> passed arguments this can get upto ocfs2_local_check_quota_file() where
> the passed superblock is from the ext4 filesystem and that can cause all
> sorts of interesting things, most likely crashes. As ocfs2 quotas are
> specific to ocfs2 filesystem, verify we are indeed enabling quotas
> there.
>
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Mark Fasheh <mark@fasheh.com>
