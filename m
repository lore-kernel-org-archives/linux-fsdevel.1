Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F70357D0F
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761864; cv=none; b=eeqcYqO8fXhqzBM0jyWmDY1K/Jsnn49LobX5rt6xWlthMLEiHi+4KsGp+yVUbPeh3PZ05pxL7XGfXp+uG+GXANwgD7DZjHbA6+g23Pks4oH86359uh3DS5JAlvJpvNVlC2yPBq1lgo/qG3uI3YPv3N9koxbpJS9DO7rRgd7CZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761864; c=relaxed/simple;
	bh=nsDZU6lH0ABxd2mkaqWWWwpJUUSibbd+Sb86MxXWU3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKDGkAkspciazuyVHxDffEOa3e2+Uqfjc3Sn3xH3unC+/CRru4dBs/GXxwS/a0i1Nhe/WQsrII9itITmPAdQM3na2oBwo4wjITKKpnsqYAwKiGxIRdtRLmhi2mdcaMdYjin8tkc3tJXdBZoLkfN22xODMl/9VOjddn3YT5vPH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=nH6Q3nSy; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="nH6Q3nSy"
Received: by mail-qk2-f40.google.com with SMTP id d75a77b69052e-5332a80a731so44799941cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1790761862; x=1791366662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LCubAwWVijXqS4BHl9nvH1ievcAHTddydMzemiE8ous=;
        b=nH6Q3nSynL+z5y2MWgtfOAYJ9vTFbt6j6qcb2OVEFFhDO/7aqKxgO6uA+9AK4RoUCK
         ZKpGKmlJAocz//XygoOR5oLZfiC6JGvGzn+jtW/R8gd9BBHjfVE8cFgNnXSwGDJmUA8w
         DHRl5rHoU1h4ZoCRvMvvRPpKQ6GMzUj/pPrmImoxEmFOk8HJEaysmVVLKeCT84Lm8UDJ
         aPk5ZqTXdqlpFbt/ED9ESUrHddQBBC/Q3Rbh4/nRi2LQaQaqYEusnc5kRgp6qStk+om5
         DFc35WCkNJZHf0AJnjAu/eBZ/qKGn3Lg2ky1229zI6iOO1vLmCZy3gbzhvhaEDXPSuSW
         GUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790761862; x=1791366662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LCubAwWVijXqS4BHl9nvH1ievcAHTddydMzemiE8ous=;
        b=chVBefP3SF98yxOsPhwWYO+MnpWm+k9KqRqPDtj9sMou0Ab0da5VsOzlME3u7hmdjt
         6UEN7AgidnlOogRkWS6/UTt0FjQBav5Q+k09w8oCvHMVRjZmnlwY4A52VdqI/LkP5xg4
         EDvNkP/7VvbV/iFZ6noerK8D5ctUIdsCimQqng9pMsMtU/ofpPl9PLBApYSA61VNMfTe
         Ku3DuCNSMce/6RDq0VRDPI6sAXBE7DBdPQJ6Z5yNxo0AwcbUg6qBC3b25W7CZ1sa60BU
         doGaGygeEe2xXQwXci6T2Yxu6eErr14FndHs/0T0JCKLe1MCT8CnZn0bwZ/++o/1l284
         x2zA==
X-Forwarded-Encrypted: i=1; AKwUvBy9i5V8UdPjqXHnHiZ8Sv6Gv5lMtTYnCODfxCyK8DlUANZFbH0Q5TwzJjqbzhCE772Wzvbt92d2o90rbZdT@vger.kernel.org
X-Gm-Message-State: AFuF++lJUjPBXrZW6p0Za3/qdRp5Veblz7+Gd9s2Y9Io2qzFc26cItdj
	cdQSpjQjq4IpeI42ywT05PI2cL8d9wWK1P6Co21MD/rB4H42GN5OlBr2EKO0B2X/5w==
X-Gm-Gg: AYBFou239wFAJaascCnTV9GRUF5CDRds6P+omuXAjOoQM+7RLO1YpFf545cClzc6wte
	5NGt7LR2gDcGbAyKypQ7Qn/gL2Drpr2/N6HkxYTQk4OUiou7u9N3jCxzDkN+FCaXgqwNTfCyJv4
	wYu5c9SANRrc44p8wc7AORXge9CcfQScJYI8eNSBiZEmHY0jP1lFna/9i0/89t7IQnlh5JtxVOF
	1PFtuYCisG4EQnXIq9AxcsXLCIvBGXNjIvvYNvY2v9VK6EGHctGXTv2YpHJ6Gdh8wk5eoEJyysW
	cJV9vNWYaYbQH9ovHyaZIBjqqAE+jk2/y9/6hst2z1wUca5HBO74N+sQZK6hrsV/mWPwtdJFA/S
	dLC0cKHECgyDjEVJS68PKkc7/xWOxSnDWfr5HA09uJuMc6zyUzK8b8lUVXcFCSlsjdMl5Dx7us9
	r2SyU4+d4vDRWktBQ2gIzAkYjwxP3EW6o3WmHfuCWm+eTozsWWCuwSUktCJ2atOLNKPUxmQXViU
	sBqjTjyVVaEVdqOu47nzl+9ss28H3c/
X-Received: by 2002:ac8:5a01:0:b0:532:be46:5b07 with SMTP id d75a77b69052e-53374abf22amr13892561cf.23.1790761859955;
        Wed, 30 Sep 2026 02:50:59 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53374118024sm7797121cf.26.2026.09.30.02.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:50:59 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: joe@dama.to
Cc: brauner@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	hengyul@cs.unc.edu,
	horms@kernel.org,
	jack@suse.cz,
	jirislaby@kernel.org,
	kuba@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] eventpoll: return -ENOIOCTLCMD for unknown ioctl commands
Date: Wed, 30 Sep 2026 05:50:58 -0400
Message-ID: <20260930095058.1062123-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arWdMDek0iv0obDy@devvm20253.cco0.facebook.com>
References: <arWdMDek0iv0obDy@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Sep 25, 2026 at 5:59 AM Joe Damato <joe@dama.to> wrote:
>
> On Thu, Sep 24, 2026 at 02:57:47PM -0400, hengyul@cs.unc.edu wrote:

[...]

> >       default:
> > -             ret = -EINVAL;
> > +             ret = -ENOIOCTLCMD;
> >               break;
> >       }
>
> I think based on the documentation this is probably right, but I am now
> wondering why both ep_eventpoll_ioctl and ep_eventpoll_bp_ioctl need to
> exist.
>
> Maybe when I first implemented this I thought it made sense to factor
> out the busy poll ioctls into their own function, but in retrospect maybe
> it's cleaner to just collapse the ioctl function into a single one
> instead of having two layers?
>
> In other words, maybe:
>   - delete ep_eventpoll_ioctl
>   - add the is_file_epoll check to ep_eventpoll_bp_ioctl
>   - rename ep_eventpoll_bp_ioctl to ep_eventpoll_ioctl
>   - fix the test (as you did in this version of the patch)
>
> Would result in a cleaner fewer helpers / cleaner code ?

Thanks for taking a look. Agreed, a single handler would be cleaner.
Two things I noticed while looking into it:

1. With CONFIG_NET_RX_BUSY_POLL=n, ep_eventpoll_bp_ioctl() is the stub
   that returns -EOPNOTSUPP for every command. If it became the
   .unlocked_ioctl handler as is, every ioctl on an epoll fd would fail
   with EOPNOTSUPP on those kernels, which is the same problem in a
   different config. So the stub would need to keep a small switch:

    static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd,
                                   unsigned long arg)
    {
        switch (cmd) {
        case EPIOCSPARAMS:
        case EPIOCGPARAMS:
            return -EOPNOTSUPP;
        default:
            return -ENOIOCTLCMD;
        }
    }

2. The is_file_epoll() check cannot fail there: the handler is only
   reachable through eventpoll_fops, so file->f_op is always
   &eventpoll_fops. Unless you would like to keep it as a defensive
   check, I'd drop it rather than move it.

Since this changes the errno userspace sees and 18e2bf0edf4d is in
6.12 and 6.18, I'd like to keep the fix itself minimal so it backports
cleanly. How about a two-patch v2:

  1/2 this patch unchanged (Fixes: 18e2bf0edf4d)
  2/2 fold ep_eventpoll_bp_ioctl() into ep_eventpoll_ioctl() as you
      suggested, no functional change

If you'd prefer a single patch, I'm happy to do that instead.
