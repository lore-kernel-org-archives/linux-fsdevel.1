Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846CC352002;
	Tue,  1 Sep 2026 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257587; cv=none; b=AoSb2Ko0+8KJ+TI9sxodUOdzmOqLSDQjb1t1TN4cG5mAgcON4DcgE/M2ji+ThQVi1BvqbSqQ82jzIe2BEZDzj+jZyo6YKaVl+qkgu7eeCoBLSEWexGw3mF/aaSd4glMvEuO1+QYI/wRu01Gx/kPjJahPr4Aw63VGh8gMPptafc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257587; c=relaxed/simple;
	bh=2O0RVVBaXdMZKOkOPM0Is6k0h2WcJg8Nu3hBLrIa0l8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ux1rmK4vvUJy+hAr3G4RRYTE6CFIZfANLpma6aWtGo+z2dPcZ0wgFiLVDKJoL7YizKK/BHJOQOIElErzrrm/M3onhkk5A6ngbA0nCDHEFJEs+8NcR+XR3oFEUWLUAsIBhGswK8jE0lMbZz/J5WcQoxXnkY34o/aXhsMEtTFUHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=kvo8KZBD; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="kvo8KZBD"
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:86a0:0:640:75de:0])
	by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 7867D80B6E;
	Tue, 01 Sep 2026 13:11:21 +0300 (MSK)
Received: from i115078296 (unknown [2a02:6bf:8009:1403:13e2:aa39:7988:f1b2])
	by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA id KBgVjB0jGqM0-afubIIOL;
	Tue, 01 Sep 2026 13:11:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1788257481;
	bh=2O0RVVBaXdMZKOkOPM0Is6k0h2WcJg8Nu3hBLrIa0l8=;
	h=Message-ID:Date:Subject:In-reply-to:Cc:References:To:From;
	b=kvo8KZBDk+plF5FgEXfPM9uA6rQlRvN508Rfu4EgJZJq+cGUos0Jh+RS29o+Of7TL
	 NTil3waiJsjtIRgO8QqBVD77I+Fm1LnhFMZdtYDL1DBCL65nKNPE8f5igpZfsONNSx
	 +otnAc1DpkoDNG/rGKrGI2PAlwNfQvWhpAEQRk3w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
References: <20260813-deferred-dirtytime-iput-v1-0-ad2fb3ad6bdb@yandex-team.ru>
User-agent: mu4e 1.10.9; emacs 31.1
From: Mikhail Rudenko <xyzzy@yandex-team.ru>
To: Mikhail Rudenko <xyzzy@yandex-team.ru>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] Defer final iputs for dirty-time inodes in
 PF_MEMALLOC context
Date: Tue, 01 Sep 2026 13:10:03 +0300
In-reply-to: <20260813-deferred-dirtytime-iput-v1-0-ad2fb3ad6bdb@yandex-team.ru>
Message-ID: <864ig9s2m4.fsf@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gentle ping!

This is my first contribution to VFS (but not the first to the
kernel). At this point I'd like to know whether my approach makes sense
at all.

--
Best regards,
Mikhail Rudenko
