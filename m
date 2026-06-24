Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD3938A711
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285155; cv=none; b=QfGsI97se3O5+QBirEhYK2h5CiICUSb3xp6nSV6pOgjUMvJ434gmkEKzI+ONPb64E2rjcpbH/91CbGDJy+sNAMIN99TEwhy3jfrFB77HbL7OJmj3nsFKSMTUrYQ+CaSa9gw+OEEIfqh4RH5kdZjypbt0v3LhpJPXkLla6uH264k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285155; c=relaxed/simple;
	bh=T+oTEsZifQSSjkTTm8dieBj546vS01rprc6FRMPpgRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJVUivRpwRsWu26/acuKmu/6teS9LnchXO8OFL9ZWa/28ogirTVpl0aMs4fNu+xOxUhinAGzgZnL+WJirrAjGJ0g+ALDJlLXDwFrx93OtffNVoq8UJ0dzl2OBVq+/bjCjFZn6fSH3aTZ5WpHfa678SpX+PQqWtkCWP403urkdTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEk6jZgM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEk6jZgM"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4624c1409c9so537224f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 00:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782285153; x=1782889953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhG9FcF945Re4Q58PUpr7BwlsxWpmlT6fgah9/vT28s=;
        b=NEk6jZgMulgJqN17XPHyzxZWrjC3SRgX+YSWsZTjYh/fBnelCNZujLrpG/e+mFyoF7
         f1Gq3XqQrb60v77rGI8/iNo2sqx2/b7UaQAXvH3QITshpe3OUojUSyJlLvUAe2/GpKjU
         SE3hQWJrn17c9XTEnFuUX50Exw4ddu2TEcs+Jh3H2E1/KEmNBi8R2E1viN8X/RS/F8hf
         ArU9eVXTMzswldd/Um38NKIYizUTz23JNVE2PVtj38Gk/Zuo1ygshyyt6BVLAHby6pN0
         x3Dfz9pBCe5euKHjThKElffKbbO9TKgxcg8aVoI/xbwPxYjVbF266rAnHHl+iApuV2NX
         Ru3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782285153; x=1782889953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhG9FcF945Re4Q58PUpr7BwlsxWpmlT6fgah9/vT28s=;
        b=C1l2XZCWRNCVL7fiQ2xHyAjQASQ/3KkqYQz9+t+0aiQOHnxnc9mKFa67ihBtLSTgGc
         9rBXkF/1dt4SVZRwixmUId4PH6aYx3xoVTVFBFLabrczu/OQ88P+7YgkYFlcRVhNlAl1
         mu/NCKY9YCOXC+O68TA01eN2zEJZHjgi5TvQLccu/LLwk5wxp+oQX9RC35cWvP4kYt8U
         nEHPMMLEZuBuKR6qsB3Hn/hsaxmJ3mwo4hpblvUFrovEQIBuE2fCDfFapXngpX4q6gQ+
         Is0kJ28+cACo+FBOLuiTw+0pfmzymSS7NgwPR5WwmXaX67NvG/eqZv2ApJqC+eDnukRe
         ELiQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhFAyOvHIco/lJdOo036drB9C17MyhQd2I11hJq1bUNdYhh1ux8uYonA/0Dc6NvJW2HC3eJ2x5BA3soEcN@vger.kernel.org
X-Gm-Message-State: AOJu0YwH5o3iVIlj6UVrbqRWbJ1ZEV/08Qy502kFH49rKpRiAPxW1eqA
	7QKU3mBiojBjF/O0UU7O13/Qs40w76d+cukzmJlNgQ0YQVzgKBKZP9nF
X-Gm-Gg: AfdE7cnN7W3C0xe3BlDJi4aXi1Fl3L/68CPbuZhKnql0ej5lamzFrCT+ywSS5xxGgpP
	MUAciYrBSYJFbrUlAatF9Ot6dw/iU1u+1hfbrYD2unITBoFLj5chsy/X3pzaQHsiaGaJcqV9Ahl
	L8QlD9nzJpKsIW4EfVOj5F3ZiBlh+sMpdHuFy6ztAt9WB0J4R0f1K870A5mBOmGGaNcg39SNWfz
	lFnA4MKyVoPSyhxf6T54NMpzDOd6d+AsXPzJ/qJdPjQtq7sq4ThBpy7iEzKE2BE3IMnstBimjTN
	vxfsLCc/THVzPZbHD/rPBiHL3yA8cAGkT6/MQtPtMSPZdwVL0BnVq4MToHapjzpyo8pnQRsvzbu
	R2sXGa0De+eqgl2NvuYZVNEFgF5xr46C/QiFHJXLk8MQlW8iEC1Eof7nkk8Z7BumPN21DECZ+mo
	E0A8WqB+ok
X-Received: by 2002:a05:6000:4683:b0:46a:1f35:113f with SMTP id ffacd0b85a97d-46a1f35172dmr8359155f8f.21.1782285152523;
        Wed, 24 Jun 2026 00:12:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c1ee0189esm4296531f8f.9.2026.06.24.00.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 00:12:32 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: avagin@gmail.com
Cc: akpm@linux-foundation.org,
	alexander@mihalicyn.com,
	axboe@kernel.dk,
	bernd@bsbernd.com,
	brauner@kernel.org,
	criu@lists.linux.dev,
	david@kernel.org,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
	hch@infradead.org,
	jack@suse.cz,
	joannelkoong@gmail.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	val@packett.cool,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Wed, 24 Jun 2026 10:12:26 +0300
Message-ID: <20260624071226.2272209-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
References: <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrei Vagin <avagin@gmail.com>:
> The CRIU fifo test fails with this change. The problem is that vmsplice
> with SPLICE_F_NONBLOCK to a fifo file descriptor fails with -EOPNOTSUPP.
> 
> It seems we need a fix like this one:
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 429b0714ec57..6fc49e933727 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -1253,6 +1253,7 @@ static int fifo_open(struct inode *inode, struct
> file *filp)
> 
>         /* We can only do regular read/write on fifos */
>         stream_open(inode, filp);
> +       filp->f_mode |= FMODE_NOWAIT;
> 
>         switch (filp->f_mode & (FMODE_READ | FMODE_WRITE)) {
>         case FMODE_READ:

Does CRIU actually rely on ability to do SPLICE_F_NONBLOCK vmsplice into
named fifos? Or this is merely a test?

If this is just a test, I think we need not to preserve this behavior.

I did debian code search with regex "vmsplice.*SPLICE_F_NONBLOCK" and I
found very few packages. And it seems all them use pipes, not named fifos.

(On speed: I still think that my vmsplice patches are good thing,
despite performance regressions in CRIU.)

-- 
Askar Safin
