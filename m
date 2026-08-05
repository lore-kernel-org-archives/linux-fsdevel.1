Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3C41D110
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925142; cv=none; b=S3+Izpgab/SRH7/nkzmNOY6ERiuC5OgLq9sC84VbmFQmYaOU0wtDxA7MPQMzcfxS9oaTgsp/N8BDVzTqk8PEBL+v6N/8uG5RviwifxRVfDWbQJl+YDkuEjqnAO+RReTTFf974KsPErCM7JLGPZsxq9ofB3L331d8JTdmFtXjJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925142; c=relaxed/simple;
	bh=5LPdUY8vOD7tCOgpEMmMuLSpVOvHw1/BZwcBrOcaa5w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JqrI4BMoYnZwS+0lLrLIrOAbW1VlQ++wayWNEkmVwWl5J5r1vh9tCnNTUyzHH3VVpdOk9plz2FZuKvdFFdR966ErGU8FqrHeLowz037Y5pITGXaEUrfJfw0PaYXXUl8rEjBt0+1zXgG96LClSbREjUcBkaNoD53yj+HS96WZ17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=PxI7Q62T; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="PxI7Q62T"
X-KPN-MessageId: 0d599585-90b7-11f1-8f54-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0d599585-90b7-11f1-8f54-005056992ed3;
	Wed, 05 Aug 2026 12:18:50 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 0d5279f6-90b7-11f1-91d4-00505699891e;
	Wed, 05 Aug 2026 12:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=ziogFb0ci+ueCyC4nXoTI8IVCsO4t3uaJI6BsJKR554=;
	b=PxI7Q62Te1qdEYFdgM7FXqkKvqp/j4CAdTBJfNzCPYoC6TimqKRgZH/Xj/K01Wiz9r1CeJNyLozFQ
	 LXKeCcT5uj6IDWEJ3Bzx0xatipX1pzqTrbDkq4kbKCGzBXyXHH+juUhUJGr8D5zhooGpULgmPQhH0O
	 ToX7u+EBOJTF9Z0an1HNjDyNNluHlzg3g2EJYXVeOBB7Q082JoG9c6AbcpGkAXox/4EOj55u4AF5N5
	 1ILnGDan0H+ctXSpVYjJ/zOeakUp7yJpYQ5+vCDaKaBiuoqvrBkDQMX6Yu4WeG0ItPw+Hig3uofsij
	 VtV5cNdprhVgCVjCmVsypwdUzOjxSNQ==
X-KPN-MID: 33|Tjcm3NSn66GJSZI9e7XFO9Nvaj3eSYKJK2AUMSxwvh6SgA1PzgEzNGyKhiq1Wi4
 GkhW2CxfXhZO9ndUhJQoTUVwHaefRT05cEoEgAQG0Smo=
X-CMASSUN: 33|OyO4csm3fn0ePujKOoZ5lESdzTI2BjzEi02ST2IdNORCu713/x9e1pLmST6IyRM
 CNTu9DfZyrjF8Zo1YcG+t0Q==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 0d46a492-90b7-11f1-916a-005056995d6c;
	Wed, 05 Aug 2026 12:18:50 +0200 (CEST)
Date: Wed, 5 Aug 2026 12:18:50 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1227047202.267333.1785925130131@kpc.webmail.kpnmail.nl>
In-Reply-To: <CAAVpQUC7O1yiKQ+3FcGWbDkmcd-LeFc5tCC0vF7QgioVOXvb5Q@mail.gmail.com>
References: <20260802151212.3294591-1-jkoolstra@xs4all.nl>
 <20260802151212.3294591-5-jkoolstra@xs4all.nl>
 <CAAVpQUC7O1yiKQ+3FcGWbDkmcd-LeFc5tCC0vF7QgioVOXvb5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/4] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 04-08-2026 19:26 CEST schreef Kuniyuki Iwashima <kuniyu@google.com>:
> 
> > +TEST_GEN_FILES := scm_rights_denial_lsm.bpf.o
> > +
> >  include ../../lib.mk
> > +include ../bpf.mk
> > +
> > +$(OUTPUT)/scm_rights_denial_lsm: $(BPFOBJ)
> > +$(OUTPUT)/scm_rights_denial_lsm: CFLAGS += -I$(SCRATCH_DIR)/include
> > +$(OUTPUT)/scm_rights_denial_lsm: LDLIBS += -lelf -lz
> > diff --git a/tools/testing/selftests/net/af_unix/config b/tools/testing/selftests/net/af_unix/config
> > index 41dbb03c747e..468f7a0bb64e 100644
> > --- a/tools/testing/selftests/net/af_unix/config
> > +++ b/tools/testing/selftests/net/af_unix/config
> > @@ -2,3 +2,10 @@ CONFIG_AF_UNIX_OOB=y
> >  CONFIG_UNIX=y
> >  CONFIG_UNIX_DIAG=m
> >  CONFIG_USER_NS=y
> > +CONFIG_BPF=y
> > +CONFIG_BPF_SYSCALL=y
> > +CONFIG_BPF_EVENTS=y
> > +CONFIG_BPF_JIT=y
> > +CONFIG_SECURITY=y
> > +CONFIG_BPF_LSM=y
> > +CONFIG_DEBUG_INFO_BTF=y
> 
> Please sort configs as CI complains.
> https://patchwork.kernel.org/project/netdevbpf/patch/20260802151212.3294591-5-jkoolstra@xs4all.nl/
> 
> 

Oh that is pretty neat!

I wasn't aware there was a canonical sorting for the config. This should fix it,

LC_ALL=C sort -c tools/testing/selftests/net/af_unix/config

correct?

If I fix these issues today, any chance we can still get this in before the merge window
starts again?

Best,
Jori.
