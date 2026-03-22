Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34037C108
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774183135; cv=none; b=sRyuw3txUhwsapmga8wichO4Th3bbctReOFpJqZMReKmC5N05jxhbMnLnfGsWxUFjgfjGc1knKfslegVvDGfOxL733sdZEOLbhqxhT9xc81O/ib2wn73GFlntxJAPx5en8mVguAqA3PGAwwoHuGNMVvGRG1lbSF/rU3xA+VcG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774183135; c=relaxed/simple;
	bh=satYM5fGm5NxtEO7gQHzgrdT13jAV7/jwxl6N8n0VR0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=eoq9oPZZnp2ELJMXc0I5D/aO3aqcxKf4fZdb6KvXZ+RUIJaBSeeFP8tl3rO6+x3ZScR9NfVl/E2+IzMVjga51/EONTGRv/WQXk20gIJGhMuCPYdWbwcMnIsR58ouCSz6vjKn/PnSVqWKUBvO8u+y7V+lmJjy85dJ2jBRHcRxWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-672c40f3873so71473290eaf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 05:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774183133; x=1774787933;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=satYM5fGm5NxtEO7gQHzgrdT13jAV7/jwxl6N8n0VR0=;
        b=DUdr3+eDO1nD1xp0d8KGhiST39aZgep0/soGYIyezjLltgaqmP+pdHdtU66l9it+hq
         225Z80H3wo9347iRpgMJiCrX53pkuLIPQQFtoLhOk/Sl2NSeSzk3IqoNQ/HjRDmT+u3q
         XHRstBa61abgZaF0OvMFk3eDVNyfHugIvZdkSD1XR3TDOh2W9Yt0+HG295C92sXNDHKo
         Ued+S6osgTw5wu2uiR5MAuJa4u4fd/r04m+pKX4bYyDORmz/XTm5acZErggCYdAQ6IpV
         a3hb6zhrEkLPxg3KK/6VwL/0d4e8aGDgQCWSQncd9QTZAsYMk4ZxkstkMbd/0khZkob9
         04QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoHuJungX25WWX2gvzTYojTmbvMxpNs70SzJ9rLwYAdGYqGRaJnBAFzEtkNg7mkfyFSe7QREeFDWA2JmUO@vger.kernel.org
X-Gm-Message-State: AOJu0YwRFg2i7unnXcG186n+2V8Ooi3sWiYOL64LuBi4bVoiF34B2mkG
	EaaE+5aZRuY/nOOUUKjdTt3SUcTf9Eua6go8N+n7U/fUdT8rpBtRt8cWX9/I3UzfcT/ytiosAzc
	CMtc434kqA5mKqys2Kh6I36qdLwhzTS2PbzTIGo4auzxWiCyj2sJJ74utkF0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b94:b0:67b:aac6:640b with SMTP id
 006d021491bc7-67c22ee4831mr6499198eaf.26.1774183132930; Sun, 22 Mar 2026
 05:38:52 -0700 (PDT)
Date: Sun, 22 Mar 2026 05:38:52 -0700
In-Reply-To: <20260322123545.39132-1-dxdt@dev.snart.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69bfe2dc.050a0220.3bf4de.007e.GAE@google.com>
Subject: Re: RE: [syzbot ci] Re: exfat: add limited FALLOC_FL_ZERO_RANGE support
From: syzbot ci <syzbot@syzkaller.appspotmail.com>
To: dxdt@dev.snart.me
Cc: dxdt@dev.snart.me, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"


syzbot-ci does not support `test` command

