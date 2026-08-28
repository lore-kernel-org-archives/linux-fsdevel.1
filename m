Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315083AE6E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889060; cv=none; b=t2fLY8qLhBlTPuBvg7ACa/M5+1eOuXubigmdunD/wSwmxY0fQUMuyknKVaLa1VKg8kynTJqtCzNA0o3g3vURYE+HzQ8SFCUp6zNepgwYQnRLBcyMxwIzxUsbGUn4lMloBWIwpC3SMVysE/MGmzz6omSirAX+M8yi5kCKsDmtP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889060; c=relaxed/simple;
	bh=yrD9iOqDSB+oA90GXdxJg3QYf9+2okRVN+yypqMaCMw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=njH9yKap1IVkZqQAk1NDrqW7F4+1df8wB/1MV4I5JZ5GmTRpKeO+c1zvRIW6IOzXQE5+98/wIc4jpP7zOf/ujZK6KykZ3DNaHGqWhWD8liAMrot4eZVj2lcqhWlghcmaxy+typ5qL10NzZDKhjEl3Pkro+l7rbXqunFDFjVJIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNg+gNHB; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNg+gNHB"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so374295a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 20:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787889055; x=1788493855; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2wKk+vB+goqKaLt0KMnxh7usyJz614ylfhLbmhKrkpw=;
        b=tNg+gNHBwrm6Czb7+1YXA7m/VPYRAJfjrLQwWkwPI7/WMsAJcUyj+YZhe8fdsNmVMe
         bDHttCaPNPeym2foe73qBZMQdhm57Mk0Nc8rspwNXOEGBTf+lt5O9fvsGonUSxd0UobP
         Q9+p/ImuF3DQ/hjk6CNUVToESB/iaaVxCsT59Os5MzALpoAILPbIdrcmz4hN5TAIY/A4
         nsRCPv+TsZIpAsvTWCzVOYAeUdM792+u0QLg9izbIwJHZJdoB2Z5xEs2Y8sJPIG+QFJC
         HIJBq4DV8CxAaXcxjZsEdV+DZwfzCMQ6aq2TBnmDw1IQB7F6VDImJuVI9b2u1NeT0CYU
         qMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787889055; x=1788493855;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wKk+vB+goqKaLt0KMnxh7usyJz614ylfhLbmhKrkpw=;
        b=APD8Jpspwzujflc76ou8v1XgJbBcWeyxyOsczwjipD6nP/bykopuP7BjedNnjG07y+
         761RjgC69Fsr8G/NQqjotfkdJQgoIDTRcTV7fdTUVAnHeIRL9i64N4I7+W9AUPBh1et1
         pksekoeHtKdClGlVZGMb1ErS/A284QYfxxSMAdlhIALdmTKaiGCfgyYUWK6/jBmMCSj4
         ApopghdSiYHCrRMo8DEvj7KyG/hPCCWDw11zvUSbcGb2yA8FfJF45lyQO2fOnrWB60IM
         ugQTbBupL7erJIYAUF3WoVvT3UCEDsJ+mITrNHkpqabzuIUlg/L8nK4Ut2+Hz7NxvkjY
         orfg==
X-Gm-Message-State: AFuF++lETLOgebanRFPLPdRoYDM1Z3/DWgtUH6c49UQnhCARxLWy88BT
	PN8/UTnE7F7TNC7qAAvC7wz2K5rwF1FpsrBKcBcGYTzzV5pqbulR+oRQ
X-Gm-Gg: AR+sD11cRqbd3fT8vymAwoEruFY2Ufj3TCAWdNPxYjmvg5wA8mGK9dZetTCvjXd7+ZV
	rRptJuhAbjFxRAB7HoiZfxZfZUkTyNaX3O4f+8jdns4n5tc6bbEAgRMFFYJLaWueiDbGLgY+3S3
	kvmimew/CfjZeZJXzVPfcEETBhgJrOiv4t2/mqKeUYSGiuj2Py+e+AZ/NZGGn9o+s25MK1kMvH7
	MXbqF3PFb5Z40DBfJFmA5Zhq+aBvw27a1ThwqxK2SZXw7HKsgrLPoBF24Fm1+tSZg2E4ROdv77s
	cW5Sy+mxiWvgOI4ILzrKIy96At+5x95/QCN4XBGhtd9SgVmWGl3EBAUjvzYGQ/xWUqWKVTwQW7f
	hfUBNadxRspzuoqkQMXsMG+PrBSfCluQwNb3ufPFpLm+CVO+ph0CZutsJZHCqKMFS/Hcb3hRav+
	MEzGEtk5XMn+4wuCUqMBMi5U9F5N5/TbVxEgh+3NEC3tpWAoTSewlYMMxErrFGo2Xlkw==
X-Received: by 2002:a17:90b:5284:b0:396:4dfb:5890 with SMTP id 98e67ed59e1d1-396d0e5bbc0mr8463160a91.2.1787889055213;
        Thu, 27 Aug 2026 20:50:55 -0700 (PDT)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0e0e67dsm1659184c88.15.2026.08.27.20.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 20:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/3] binfmt_misc: document the field delimiter
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Farid Zakaria <farid.m.zakaria@gmail.com>
In-Reply-To: <20260826-work-binfmt_misc-delim-v1-3-43618adf8599@kernel.org>
References: <20260826-work-binfmt_misc-delim-v1-0-43618adf8599@kernel.org>
 <20260826-work-binfmt_misc-delim-v1-3-43618adf8599@kernel.org>
Date: Thu, 27 Aug 2026 20:50:28 -0700
Message-Id: <178788902862.3236768.2911438482058639296.b4-review@b4>
X-Mailer: b4 0.15.2

On Wed, 26 Aug 2026 17:55:48 +0200, Christian Brauner <brauner@kernel.org> wrote:
> Document the field delimiter.

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
