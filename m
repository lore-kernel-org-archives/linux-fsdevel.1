Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B328834
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776598728; cv=pass; b=PfXmE7yvzc+4acGdVSNTPuXfADJPo5VOllWhK2DjRvszsda+2XTi56AzsKcQNkHUUdJVlTCELQPRGsSYPP12gFgGlFVlqtJ2C5T/lQxdhq3JBFGEr9Yg/I8j0Nn1r8lse/pFCjMVMrGuLh/uoDgBgaIoKHQWGDjGukPy93S7w9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776598728; c=relaxed/simple;
	bh=qbQHTXma8wIRNuZGSeTXqTSf6TBje7WdfA3xxklNbpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9ZcYJ0XJqf//UVa/gC5152XBK/2NOHGkarkBd/HzmP6azZqDHMXDGm7skxargRm7C9x7DKntZnvBbh6UF9+VPhMBjUe4gQc5cFsHfvLpedpy+9MXDmeq/GH/LDtiuNtoZrtO9hInnk0yGscqEkBJvQFKcK7Ya94ja9F1eT7ILI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e37w93W7; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e37w93W7"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-672c23aa064so3893406a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 04:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776598725; cv=none;
        d=google.com; s=arc-20240605;
        b=SExcQnecBzVhmIGvvwhYBDjrp2pT2jEjg5yoTZ5+M404+6fK+ml8zc4t7xQhTlVKzf
         zwQUCfwHL2cpHLQWg85nykuHOwdW8N4DxZniJkyq8UqEduTKdAPBkN5YxLwwfWby5HZe
         vl8jEoxC5W5p2r/aKqEkiaKZmj+GzZSGRl7U3YMOsbOjy9DBMi82qKUCK7vm2MuzwEkT
         Kr8/xjMSw2FQiIBVNOUAJDtpDdC61U+zZlx1lKtGFeDCCjIWJjRqJ3k+pcAHY4aJ1qPF
         hMfUm07OAHNWIv2MtWQx7o7PCht0CMPCXQPi1h0FEbd81w+wgB38NEOnDVfZKoh5XBLD
         snBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qbQHTXma8wIRNuZGSeTXqTSf6TBje7WdfA3xxklNbpc=;
        fh=eCKz6FgqJtPRX/3bZYpdlW3zUa/S5uqkF2fBCkbcZfA=;
        b=Ef5YBTzHSO5wLd0svBcfsWM5tgkawDlql2ptr1k1QUb1Q7/tiaQXRmMlVdy9oYd6PV
         s80TQguJozDiqdtpa3TsZU7v1psLED7OwuZZlE9rJStm+zGEut4RaLqx+eL3UrBFDHYP
         sBDCjKVcs2K4EbSLpGdHbZTwy5nKO0Hn9CfL9YUg2rImyFowaO4jQirRQrtJj7JcimIv
         o03+t7hInIjPa4vT+SYamGnabwoeuK09Rj46d0t4Efz8P0jjhr0KMa33VHf6uVfIRTBX
         SsY2D74DqXBKDzbSl6Xlp7JqaBWYVjrzjjVGSdmQYuEtZSv0LSxHvSM0ZpkZkAsmaMQl
         I5HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776598725; x=1777203525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qbQHTXma8wIRNuZGSeTXqTSf6TBje7WdfA3xxklNbpc=;
        b=e37w93W7dAzZmiyEb08o1DtLIx53XqkA8rn3kBHNuPMOwhP9DRPwjtevndK1E21m6d
         fEHE+gAowoAx0xld+Yq+ZJo+SvyKWrcYi4I7TRUQAQsoIglU1mZeNWOsRLH3YcspPhJh
         LkwbTtcip3tRGQAHlUvtNjyzK78Vjv8iQcMjPm6ARfMPp8rgTCkPNc5DTBTlenskYPjd
         QQ/BC5JHEUQDyr2AAtqxUsTKHSv6O4mirWkh/XUKHO3ttouG8xqZ2en3G7JKtjQ20ig8
         uq0TLrIpjmIVViJPlQzez7OkXza+1E1FkhssXscDtw/SfRtd8RZEXBMxJ70gDntyIhG7
         YY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776598725; x=1777203525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbQHTXma8wIRNuZGSeTXqTSf6TBje7WdfA3xxklNbpc=;
        b=YIFQUctZyAR87NICT4N8S21dUhVykY5p5+GPGX0KMeEWnAKQjs383nCdWluAUQTRea
         6l+eUNOJvKvxPHfCGlQR34SRvu7oHCzbDwbumP82fUiys7+CoaAY/HO6LXAlmjM8faIW
         DBJ9xQpluBZ+vN/LaRGtqLlkED+TaHsRqB3n78XCgUupOBv1d66Bo8Xqpqb0EGdoqR00
         NrFzokXUdlXQpVlJeM/lD8VfwIpNdX9qTIreGU+PL8vz1VpXfe+z2evAtA/s/RXfbWjq
         oe61J+7z/H9zNWe+EVaFRG3QjTfhxZ2w32v8NMbj+AiTJW6zqiUC5hqJkFsj34WWtWJR
         b0HA==
X-Forwarded-Encrypted: i=1; AFNElJ8SfWw9VkhTZQnygZ1fRe8A9rq4g6cB4z+S34fnzFZaXxpfnZDnrTpYYFMcZJjwE6j9WRUL2X2hfxbYqaA8@vger.kernel.org
X-Gm-Message-State: AOJu0YykJTONgQMXb9lhUTnYlehmtJv4V9rgxUsbtAfuPvCO0LQDOtFg
	tWWVhBCwVumSo0mrHv61MXW+nBS5l9YjMpMJcyqSHz/cYc/zUlmTARdcsggo8Nfg2gxFghaU7WM
	yZ9a3hv62L9+D5JcNf+F/AqFKf9olhVsyaOMe
X-Gm-Gg: AeBDietgplaHgCVqWlMUfI6q9NPQtAUDeznrowMX6KWx6dcEFi1KSl6lxP+fzzUFJcH
	7mS+qfaoB9OKfaj9txXMBeVsFxcegoa7nq7i0rAJU0+flVPa9IK2p4VfEesPH8E1Ck4MF96VTfc
	B0erPWw/17dGaUQTDcFv4XA68+n0w3Vwth4WuQpoxY5yIX20L5W13ae6WDbpD93jIaPFpAA5ZuD
	nTRqFZYA1YLctag89pSOsV25yx6MKh+ZdpG20I/Q3AEKT5C52miCTlWdt9PffPY0f48a8NsAi8c
	q/wJ4DURbMgWDiN56uhlxSgdkiLs1R+KCqNPVLe+rkCdnMUed9WcvFfTYtAqR8kKbMsVtQnFGf/
	VhDrhjTGRN3QdUMh55Q9QiQ==
X-Received: by 2002:a05:6402:24cd:b0:66b:aa56:ee5c with SMTP id
 4fb4d7f45d1cf-672bffd3a22mr3784260a12.28.1776598725415; Sun, 19 Apr 2026
 04:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411151155.321214-1-adrianmcmenamin@gmail.com>
 <uamj3cggfd4fdvah6jjfbyqmffxaib7yj4upbnkxzudaos6ig6@xz4rhorxkufp>
 <CACwZE5QpR-ZSk=cinLBuuPtLUMnEiEx7UArtZxpbPmGFccOEkw@mail.gmail.com> <uvsbcmnyucl77ir3dvrwzt42kdw6saja2r67m7e4khw637e5hh@xe7dxerauc6k>
In-Reply-To: <uvsbcmnyucl77ir3dvrwzt42kdw6saja2r67m7e4khw637e5hh@xe7dxerauc6k>
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
Date: Sun, 19 Apr 2026 12:38:34 +0100
X-Gm-Features: AQROBzCB4duZUM275tOJwA3ZHnpstMOrw_7BOrXWkG4ex59fhzXctFR3TjdA2MI
Message-ID: <CACwZE5Qax30FGqXAqiLecu2jcBhNbPmvKhLt6C2iE=f5jk+3Fw@mail.gmail.com>
Subject: Re: [PATCH 0/5 -v2] Add support for VMUFAT filesystem
To: Jan Kara <jack@suse.cz>
Cc: Pedro Falcato <pfalcato@suse.de>, Linux FS development <linux-fsdevel@vger.kernel.org>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Apr 2026 at 11:36, Jan Kara <jack@suse.cz> wrote:
>
>
> With a FUSE driver you get very similar user experience as with in-kernel
> driver - you can just mount the device and tinker with the content - while
> keeping your code in a userspace library which removes the maintenance
> burden for the kernel and frankly makes your life simpler as well. The
> performance is somewhat lower due to additional communication and process
> switching but for cases like your filesystem I don't expect it to matter.



Well, I have to admit defeat.

I have discovered there is already a FUSE implementation -
https://github.com/RossMeikleham/FUSE-VMU (I've not tested it but have
no reason to think it doesn't work)

I will be keeping my code as an out of tree kernel option for now
though/therefore.

Adrian
