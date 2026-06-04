Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DBB407590
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573152; cv=pass; b=HhiZuPtgoWivvEld4iupM06Omy5DMQzlm5FTU9zHF8yGxC0b/1rFzhIyXpXpsVL+srm2V5FYDoXVKwu+e/B2pKiyMS62D6bsQhMCq21kqLgcD+RbSpGWdehJBsdNu4j6ezxfKtqTuqwQGx6kjKd+6PgZOrv5orqT/A0dDG/BUuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573152; c=relaxed/simple;
	bh=wIVCb2tFnJMJ3EitQ8kkm+1Ios57WCliE0rfj15yF8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vp+ukWNTJufflGclylkahBiVghxfBEV3RJpn5NimMbNhdZGjAFRjmdCmRNpTNkkwPOWVuQDrJqbe1zHlwMYeSF/Z4XwojHs4ZoOX+qSPe+bJ6wC++770IRgQlNCpMGsdlHq7XRdIfM/70HEew1JvCV2KHXm7hqhgk6BPAMq+5AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XLeQqp3w; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XLeQqp3w"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5176bbb9384so6736311cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 04:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780573150; cv=none;
        d=google.com; s=arc-20240605;
        b=ainvEYaP3Mrd9DCnAvO8+xsu4ZbJGRiqPWIg/cOyvZEM3V6qHMb5pq0TuRYpkPa1iw
         Q8b5DDq4Ys1oqgA/x74BBpf1ePDHIImqqnG+ZOR/fYMlWmA4ejpiUS1NN3pFjruYi36v
         sgz8DvQXMa0hGY1J2J1fBHs7UW58vSwjwWdSP1yFEpAbJD824uooyEup9Op0q5W0RVkc
         WQPTH0A+VQS6Dhgk4gq59bJTSo812kihgdkGCrW6rwhLRiVD2cbOcUo/QkSv54ke6CRW
         F3hOyCwYmugrT1l4ocv1jhyuh3Mme0U5G+GeHaPk+NM+s93RuQzcPeOuftZI/9ssorLA
         Gkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0zLSTYOXdLcBAt8Q32kyk96azm/PtDRBZ0577QtB8Mc=;
        fh=CeX0KZGRdzdVNLP6fkFBfyIXQGiHzXQ4/QqfJQAfMjo=;
        b=Jx3NEDXD0yS3te97c5hSLbP5J+87Al8ZXopEsTXOTjstV9uXTRsnw0adEhjHkDBcEH
         jmIhgdD0CDbN5InzWkVhLF9oNDFQYkPnfH5K/V1ywPNECj1K5/nP7RSFn3sRdQ3jMtST
         6WxQ7+QFXj+HOp6zk4+CENO2gZd6+4pXpptMLVKlfN5bJjlEo9/2xcyTRkc8Xy97+7XE
         tkBIPtjXt9ZRhLg7UczvdepB8vfQ1qFsZIv6h9Sdff8j1iIpDoLIQTLiMwE1NWBJew9x
         +8L3SaWJHXla+Nc/hGnwUYU4IK4T7RtkldUBTObhzDZ/W8pCleJ9etXwIbjy99NtPD3b
         l4wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780573150; x=1781177950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0zLSTYOXdLcBAt8Q32kyk96azm/PtDRBZ0577QtB8Mc=;
        b=XLeQqp3wrnWRSOhWIMNNheiGg5Y0zIbYmjA68/btC/bRt8E1mo6SlspJ1WsKelb01q
         2FrztU+zPL1Qbk4RdhzanSHDc78z05cjQrX0nLhh1oKuvdH+BbiHh+krJBy9OwvlDjwE
         Itw0t0O6LN2hI6Q1oiP3KFZ2S0LiDqsdfJ0gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780573150; x=1781177950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zLSTYOXdLcBAt8Q32kyk96azm/PtDRBZ0577QtB8Mc=;
        b=nLdZg4mRhuly1no91C7lzvYdaQ2W1+TGxkixI3B6EOMxfCU40RZXOvJRf6YyfY5392
         B7s+YA0E0RC+CdwYEL8Glx1exxA4oukQGqMWRnnnqH3UlHZGtf8XOfaJWiXOyDzYWPRf
         cqNKhFFY8PuzDYaLkeT7Uj2NIoKvAtohx/BgUOHf3KkpsYA2rc96V5Cx3XTNzYEBwsSH
         LXnlUBtVmrO1CYd2pijGMT/X3neFmgPcLEJKw4Ufdmq9hOCXoQ0tkZgbJE6MTEFIwM5Z
         30e/ABpfN20dY6CVkvwyRyqkE5Ay7JHdM+MJhIjT7ZbHGtCjBdVcabB6VmfVYqlOruL3
         kukA==
X-Forwarded-Encrypted: i=1; AFNElJ8JC03mN+GQN4EHK2rjqwCk8gw3VCW9zlqLkMuS9QfKpr+j5cGUttiUN3nN6gzO4NQsrENMg3Me6liyRECi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3B6dENSgfElxcoq6sLSwxm97jRDiF4EUpolkF3ISAc6m94LA
	LXlmc9t+PcRfNNy2vXV0gxzRYLX+RDdKLbLF1SiWnrScZgyy8iWISvi+uVE0/sd/8eF8K2+yXZH
	QayUwCaLihDafhXP+KUOlQPH0ZwMSb/WYnUzgHq/WoA==
X-Gm-Gg: Acq92OFE5PieOC2AAfJ4fM0YdhGgpvFrVLByA0FjkwlpPK10EbFM2plgI58uYgzkckH
	oZ2pPs94kqncPd6Gq1zSUk114PxR0JR+/KpWqdcflcDTCzbLqikOybW2liDgisIB2abfwBpXGHB
	PcORChlQ6UP2sdQK3Xwhy6vhomEiyw9kuEPtblb1iJWWNpeWjg9O6wjN2L5RpNPojYl2IQSdTTS
	kg/kC56xR44tFsIXIZ8Lu0ewShZn1NApNmU98I/SwjPnIagcAkFk4hGlxu0Rb54UMqDk9edwJB1
	3lCnCc/LuqO3Wr3LxgnPRSm6Aai1a7m4rsrrZQ2UAmowZM3FDoftwRVkgA==
X-Received: by 2002:a05:622a:6181:b0:517:6631:101b with SMTP id
 d75a77b69052e-51778787b94mr111344291cf.55.1780573149971; Thu, 04 Jun 2026
 04:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a1d5e8a.fd5edf16.2e7427.000f.GAE@google.com>
In-Reply-To: <6a1d5e8a.fd5edf16.2e7427.000f.GAE@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Jun 2026 13:38:59 +0200
X-Gm-Features: AVHnY4KLGvpNknzBwDpkcCnrvpiWL4AIKsDR0ylrPtD1UJKuXuq4lnEgapCwKlY
Message-ID: <CAJfpegtC3Bm+_L15RXbRSgkNB_OmE4+QsHkWU6ZhxeaKZPyEdw@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] general protection fault in fuse_dev_release
To: syzbot <syzbot+5bfc774fd6dffbbc4b70@syzkaller.appspotmail.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 at 12:27, syzbot
<syzbot+5bfc774fd6dffbbc4b70@syzkaller.appspotmail.com> wrote:

> RIP: 0010:list_empty include/linux/list.h:404 [inline]
> RIP: 0010:list_splice_init include/linux/list.h:602 [inline]
> RIP: 0010:fuse_dev_release+0x19c/0x670 fs/fuse/dev.c:2221

Found a race between fuse_dev_install_with_pq() and
fuse_dev_release().  One uses fch->lock the other fpq->lock, so there
can be a short window where fud->pq.processing is NULL after fud->chan
was set.  This would explain the Oops.

Fixed in #for-next, let's see if this still reproduces.

Thanks,
Miklos
