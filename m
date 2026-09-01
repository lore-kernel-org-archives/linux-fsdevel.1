Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2705C35DA53;
	Tue,  1 Sep 2026 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267641; cv=none; b=XYL25Ew2o8Ja2Kp0dv1JPcDF4xgW7jTBd+89tR03VEjwfMHrFgQpltCiWAQz/J1LsDAIt5L3bYA/tZKPhZQAYShLRnKolZR+xbRdJitaSpXOY2SLu1hVOc+1iDcYYdZKPPOmrKY4p7CiHBku4fgOqR1hR3mYAqo6zIBVWRq/OZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267641; c=relaxed/simple;
	bh=XjX7qqSEui/95Ib2ltt0J/TcGkipBtRq3ORpYCQQAGk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=L3N0RnkHsZTvplGUVW87rojAWCFbqd0FH+bjiWSOl9QAF6papVcd76fPxjeT1ATOMk5bfEpxnFlOq3ww8KP6oYBUmFMv2mEWhg7T4q99BTo5bM+ow9GOHCVZ0xdQplr569qFslggUZ1Lw/5bX+dHzN2jYyT7gADRiUerD49SCfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=nfgNYCew; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="nfgNYCew"
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
	by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id E648480E59;
	Tue, 01 Sep 2026 16:00:32 +0300 (MSK)
Received: from i115078296 (unknown [2a02:6bf:8009:1403:13e2:aa39:7988:f1b2])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA id V0jkli4XZ4Y0-lUm04SLH;
	Tue, 01 Sep 2026 16:00:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1788267632;
	bh=RIL5BDSmnpt/clViAGgpO3bi547d2sKwxTFQZMToJyo=;
	h=Message-ID:Date:Subject:In-reply-to:Cc:References:To:From;
	b=nfgNYCewOamY7sLEfH+edyS7zierpEBeOd1XpfQXbk2av9dfIkv4+SvZgD5J+qpY6
	 YOYyfyp1t3SNWdbRLDmECLNKRxQ8AvebTYqYlxF5lQYVbER0cmhjOL1TqKhP9GAhk6
	 JSRGL2LmiMCk85BTyBbeOcL+yU5M4SCovw44DaiY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
References: <20260813-deferred-dirtytime-iput-v1-0-ad2fb3ad6bdb@yandex-team.ru>
 <27v2ckdgybmvxog5b55sr3o6ri4bkbzu6ycwtjwckrhzyazxzd@7qruolrsu5t7>
User-agent: mu4e 1.10.9; emacs 31.1
From: Mikhail Rudenko <xyzzy@yandex-team.ru>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] Defer final iputs for dirty-time inodes in
 PF_MEMALLOC context
Date: Tue, 01 Sep 2026 15:54:59 +0300
In-reply-to: <27v2ckdgybmvxog5b55sr3o6ri4bkbzu6ycwtjwckrhzyazxzd@7qruolrsu5t7>
Message-ID: <86zey1qg7k.fsf@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Jan,

On 2026-09-01 at 14:24 +02, Jan Kara <jack@suse.cz> wrote:

> Thanks for your patches. I've actually submitted patches to address this
> problem back at the end of April [1]. In particularly the problem you
> report was addressed somewhat differently by patch 1. We've then discussed
> them at LSF/MM/BPF summit and people mostly agreed with the approach, just
> there were some requests for better parallelization of deferred inode
> reclaim (which I so far failed to implement). But it's currently high on my
> todo list so I should hopefully send v2 of the patches for the next merge
> window.
>
> 								Honza
>
> [1] https://lore.kernel.org/all/20260429174850.18223-1-jack@suse.cz/

My bad, should've done better prior art reasearch. :) Looking forward
to your v2 then.

--
Best regards,
Mikhail Rudenko
