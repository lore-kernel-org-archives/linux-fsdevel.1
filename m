Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9940D409E0F
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502153; cv=pass; b=N4mug8upFh7MFWyl+Sn8FD7hZXAlDcAtu73brWaN9jongdFyo57noZl0hKBjhZY0Uj68BqaqJ/+cepGxaP1cZZ0Mh1suC3GJLp9Emobt4Gwdr26n6GXGsvPAzvfLG67/CNOeNn7sb6ineXFx+QB7Kr1m2WvinAXufMJppXZflLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502153; c=relaxed/simple;
	bh=IwpWTUyl/wKVtXYyUbdgDiW9bK6re2kyezxjswM8xj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvT338r/DMzeb5H1f2lrsKY6TF7B22PWopwcY71r+EFqUlHaT5iYxibobjaLvOigBOi81zZRdcJZBK+BmQWC+Xcsd/9QNm68w0qBMEzhPFAQkAglDC7CnxpF0vfAwL7LaA3x6dt+aRJgivZDB2SAlyUuq1/F9i+ofhB4LQV/2L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LfsgaD/g; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LfsgaD/g"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c0a81d286so8854891cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 02:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783502149; cv=none;
        d=google.com; s=arc-20260327;
        b=IJcC8kF7RXL0n7fzo7CWMSkF7e+2bJtBU59yBONzwijfGS27Pg2LoSYbdhcx2VxwVa
         oqV9/zqLdRpjxMvex/Swvu7RJuG1xva0o1+AaNm7YwxaRCbZ/iuxToDry87dJ7punqqG
         hKA7dagtfYJwAn4fopnk6yA0QhxkUTSkE3UGf1TlxGfpoTL9ODQ+VlmP8ZnU6MiRgjKv
         FlgJuqHwpwO/9fWHOq3pHuUMFsJMHWiz7g1LC/hMMolDLMjg/DWarVd8EutCM4iJm6fB
         cCRTewaRYFwmx89I8N75E5vgiXm1HVM+82fMugD+nMP72quQt/hQkzshuUvwInSX9Z8e
         sIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IwpWTUyl/wKVtXYyUbdgDiW9bK6re2kyezxjswM8xj0=;
        fh=w/1UIVez6nlTyzU8iW2Bh60c4w4qxiDf5nfJaD5kRCY=;
        b=bYNG26+QT2h0mAl6w27m35rYJjOO5h5t/qDxvbaYd7zX5zy3QHs0rpTbiV6TTh8Xv5
         H8TJWrQMRBwLlB2tOwycZwvtE1q4Ciop0CDDnt5PzGIO8PnHByeAwR+9sYtuWIeSbZQV
         KLEKLM8oBWDlb7lQyEwywGafBlmjJrjUnr7CWqoy/27LXlGwIGro/+lUhxso3wE+a6YL
         w08ivdq25W3F2cMYqX9tHowFq7QJfOXGzKsj53o9YRzH9FuCMT4dmWlOZv0TeKAygK2b
         alWOSfdGxnvNgcazlsLOuwTdZW8d5qrYVJG0ER8v42OPTvrpvGF/52wUPA4D79kwN63p
         6XVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783502149; x=1784106949; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IwpWTUyl/wKVtXYyUbdgDiW9bK6re2kyezxjswM8xj0=;
        b=LfsgaD/gDtXnhmUeUL1cL2pgAxPlVfpU5gdJVxOaOFnM8Zc8nyEAHdevpB55UWm0Oh
         r/wS4zm4UH5eARK0jICja64JClVv/1gWL9vJO+B5SqI7Cbg2eqyudujAa1MCnjMZgdbl
         IXRS4PRSISreXCDAes6Jv3EB8eYc5UbrxP1Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783502149; x=1784106949;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IwpWTUyl/wKVtXYyUbdgDiW9bK6re2kyezxjswM8xj0=;
        b=WclXtRshzLrTE5N7yAN46mrpa0SP1uUsW66sJ9SdRt8YZaJViJvhTCp4hGttGlqGhC
         mD2vom4/EHcDDLLv7BkcNzMA0rUuExWof4PeC5UUtPo2QUFjNVD1SUR6aBT+UTUy79wo
         /DO1qDyBNnBk5clwjsN3S8AGdr8n/m0FBzrkZAk9uh7hpDBo91fGjqU/7AXgilq/y4OS
         gaReizBrn0p2Y07aBusVOyfER6ofiW11CU2Eu/6rkImi27fcdAvyIODd7cEa48PrR/N3
         i5qcaY/ISgtZTAaM6Aw6CFyk7dtVR0OGRyQR6TxCG6Yy+wu3XDUoLK+lOdk7epsw7aTU
         fPHg==
X-Forwarded-Encrypted: i=1; AHgh+RrMd6U4XN1QzxxXUdUW8NE8bvy3TLJkSfckcOgG/cIiCAmLhRLKvQASDIUVvwnEQZr/2Yc0eyVmYEHkttal@vger.kernel.org
X-Gm-Message-State: AOJu0YzWz2V7soiRFsMI75/g1q4NtKGqXxfcYm7fMeKvSX0giZQwX/dk
	B8VYVBZe0v8Lo0QH3YCJf0cObS0fK3xG/5gpOCAJ+t3TLFtOI/ONS4G8HuA1KcoYq+rNDzeIft+
	/7WVq9n4OPIk1VCfbz66AuwrdMalqmwD0outMG/XTFQ==
X-Gm-Gg: AfdE7clP4DweR7Muc66wDNWILgHNm+tMA51n7iil3Fwk2nNObGgMhgImyo3jp3qkn4o
	AclPUO1oznrpsz+IiLsT1AbHZaYH8veQbfJdAmHs33GIziVkdUtRfxMUiBYfD7a3o6HhdwHUWTG
	dJKZwz5XKTTwL0i/oHCEnNVfIbrl8r8cUIXU2R6BuYRSXQX5hPWQktuZJtckwhKIEXW80z3+8me
	vlqMthy+AGC2Vhl+ayHlG96XPyNbrZMQ9ZMJfXV2wL9XzlnTl8N/CMW8hwVtSk7Xxsc7j18Kjkz
	Kr0gcp8xaKa9LnAcP5UY46bhC08=
X-Received: by 2002:a05:622a:942:20b0:51c:7aa7:e0f0 with SMTP id
 d75a77b69052e-51c7aa7e5fcmr41689831cf.43.1783502149300; Wed, 08 Jul 2026
 02:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707220450.1200943-1-joannelkoong@gmail.com> <20260707220450.1200943-2-joannelkoong@gmail.com>
In-Reply-To: <20260707220450.1200943-2-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 Jul 2026 11:15:38 +0200
X-Gm-Features: AVVi8Cdp1-AfPxeHhgZc9FUYYy-gsHRYFV4a2GSWjiwCq8piIMWPikl7ZjEBuYg
Message-ID: <CAJfpegvoUdYToRnKQEkdrSGshwpOFt2Aw30QjoY3zuR-0kLJ4g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fuse: don't clear folio uptodate on writethrough errors
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de, willy@infradead.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jul 2026 at 00:05, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> In the writethrough path (fuse_send_write_pages()), if the write to the
> server failed or was a short write, the uptodate flag on the folios are
> cleared.
>
> As explained by Matthew in [1], this is dangerous because the folio may
> be mapped into userspace. The mm code has the invariant that a
> non-uptodate folio must never be visible to userspace (to avoid
> potentially leaking confidental information to userspace) and has checks
> in place for this that if violated can bring down the whole machine.
>
> Practically speaking, the effect of this change for the fuse
> writethrough error path is that if an application does a write and then
> the server fails to persist the data or only services a short write, the
> page cache folio keeps the data the application wrote instead of being
> reverted to the server's contents on the next read. The failure is still
> reported to the application synchronously through the short count /
> error return of the write() syscall. Folios that were only partially
> written are unaffected since they were never marked uptodate in the
> first place (fuse_fill_write_page() only marks a folio as uptodate if
> the whole folio was written to).
>
> [1] https://lore.kernel.org/linux-fsdevel/ajtPMgO65FA1TXhi@casper.infradead.org/
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
