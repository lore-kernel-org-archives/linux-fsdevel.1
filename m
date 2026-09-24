Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2785E4B0CA7
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274725; cv=pass; b=rWQ0MtCvDJzjF+ILChjUWJW9AFOoq9ZoKQqqx6MidmySTLBqU7F93NUYYOV+aZ5Dkzosg1LMuNbE/Vp7zbrm+yyuKlWSSn1Ey8bi8Bj66nSxLB10u14MlmhobDZVa51RW7MRdjWdstytBzA9/or9oLQsUmS8JtgDxPrsck+IyE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274725; c=relaxed/simple;
	bh=uDFqkrBofJFmA98fFoYtS95TSJHuBD7aLkjCUtabUSA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ez9ewYiRBCdcNFK0r+C7/NUgYyACuMFkDGZ/irbY26gNZseYum7L2bGNtmGGWjzJMmnaSCw8otMOUj7mBHyC0wVGBsZ4C3R8uNo5doEE3Qoo9+DdDpVshBepnq3lxhfumb/1dAwKnESaEKgMJXWUNLY4Qa4w7rw79q8N6iAJMZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef9A01Oj; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef9A01Oj"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d8a00bcdso1225721cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 11:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790274723; cv=none;
        d=google.com; s=arc-20260327;
        b=AFxOGzFfu3IlxdMe9MejMHFS0Ui63zcUgpXNM136IYE5TNJ2VRlCX0nFWCAFbW56Pr
         hoJzryMqhUfvg9O5JBaWF0MEaMp1+SgKBlJOgFt9hV2Sx14+EGUXwZmhzaRSaGr8EANz
         BY9lzU4o8HzMx7eTpqWNGT/7nmsWfV1xVbXCzjk3U6JQTQH8zvUClUaU8b81qS56wdi/
         FyzkdXajmFkH63ABiHZFpWN0+OLVAnHiCyJvsHhhPXUrUbs3fxGb4u8wk+fD2b/LlLqE
         F9xQOpL7i7dACpLpsHYuLgHqgx6MDeIic/jWdabA4yzI4hl3WAX371p6/eahX8l4EGfo
         9mmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=uDFqkrBofJFmA98fFoYtS95TSJHuBD7aLkjCUtabUSA=;
        fh=VIHD4NUN2vnxidm66Lv9J0f2wlvRQbndTMSY+jGmUgo=;
        b=sVVC5Tuc+GxSubZnM26qqvidhg+WM8B7CdZrnsbY2NjoCSVZfeC30yKkCebNUml/to
         mFFZsGVekktzlib1zNcUNCApRuNyM4yf6w5+/nnSn1n54MoaeBDM+adKZxVtBoQs7RjY
         PxLbCzBffvZPq21U1NfGJ616cxLMcBbNeEx8IBKi+13gYxLam2+yik71olYYhgPXVK5B
         0NAU4fPz7oj3cpx7gScTDi5zEDio5vtJIGshGZlHTv5lPAIf0WGfPVLgxsouoLu6zuP+
         0PpyNDP4wehzZ2MXaRrgbJ89dysv7zAkUWj+ERQ4/wajhofVbkA6/9UGN+yu8+iSmLwh
         OSHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790274723; x=1790879523; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uDFqkrBofJFmA98fFoYtS95TSJHuBD7aLkjCUtabUSA=;
        b=Ef9A01OjUbxgRJxq/vYPVn1SxkuYa1Sr34IYVH+zc3OHrROYConvoTwGKROe3DRu8n
         TMxZyVFExpi2rsbxPZFBXepZdqrI/VgxmN8jIDegMwMC8IFOBP9b8EegVbMqtpwfMIsn
         pfNL68m8oPBuhQNvKuSr+LReDKnNLnZ06gBhtZQNE2Fc1hcsgXtQYRgDO5mnP1LLzVLn
         rZWeK4cJKU+C2D+BeMJw5HwS1tMvSYiuL6TLs9vcndPvQPRMuJwivBwujLit2R8IrjHi
         M9pozIBfecpYJxbxPK9OGrrz7J7C54Nbw7OpEU3b2+AAdpdG0SSCW4AMkZ/YShMNUOVO
         y2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790274723; x=1790879523;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uDFqkrBofJFmA98fFoYtS95TSJHuBD7aLkjCUtabUSA=;
        b=mo0sk9T5Q0F58loTq3llr1uWInL86HfeEG60TYmTxPnYrmr+d+uBG7OQYIBgcajXy4
         j0uwe4I0dxkxrAMvBP5Zhcf4RsbqVe8ABhqiowWhNFKbKTBEPzsynddt2Hf4WX5Ad2DL
         avaO3oYU9aMj94cvAGjiuX0b/hOH6zzgFHxOoVbiQDY+CMU6g3ZCybw/IJleTwcEbgUF
         9U39sF/0dcKzpa9o/VuIwfksueD/5+NHqn3i8SXmlfRaiWmPFcAzzMoSBm4PkuuGh45q
         b6wDE62hJsYNVgq1ZgPRYokcC66A0t6EnpyWBksU4xJkPqwH66/YYzb6MCPy0mgjymv+
         BsaQ==
X-Gm-Message-State: AFuF++kYces5LSGWbrVnadt38+774zFvLAVRb52DezIFHTBA6DZPlx2i
	ZAIBI9Y5/HRgcddV4uWkI8orccraacxB+Rg3UtrFyrmHgstzZRuh3Jgl/C3OdYDzAoTleZ/yAR/
	g+tPsxdzyW3b6TywV+3dvA+T1NRU1A/Y=
X-Gm-Gg: AYBFou2TTh7lo60xTT4PpgAbgR/H8W3L6hzAGLp7MVODDmxKQTfWj4/T0UhIMCYH8Jn
	L3mZLmSksjkfJesp8RGwjURzfEw2jmNQmMO7CNkk6cjYQT3LVmZLosO106E1rOHqpd6ko7wiSHW
	zCnaSEZ2fS6Q/yGMrKC9JHtXEkCmBX85ezuSB3t1bc0T8sgwRAUJWTO84liPwWW1sCUm0IkLMOv
	SqQY+f+boTSduB/vNElkEmntDCfYlI2IY6kixQYacsgyuZvaBz8hx53+thvYknj41xibMSFqw4p
	cvK9OsyfVGRbiFiHTCBORdqSl/O0j95gBY0+RllC1y1yIxa7NlKSdg8T
X-Received: by 2002:ac8:7d0f:0:b0:530:e84c:b78 with SMTP id
 d75a77b69052e-5330b68e8bemr2036841cf.31.1790274722403; Thu, 24 Sep 2026
 11:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: dave mad maxXx <davemadmaxxx@gmail.com>
Date: Thu, 24 Sep 2026 15:32:34 -0300
X-Gm-Features: AclHuK9k-zCUCCzldXTWIeyxKaAWif5I0sMbi5qh1YqkqnV0579Wy8lN53oMJks
Message-ID: <CADy8qZg5agQXatUFynt7s0QGKqFAzg9qsV_zd8OVcsrhbvF-fA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in __hfsplus_brec_find
To: syzbot+f957cf00261d1c41fafd@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, Viacheslav Dubeyko <slava@dubeyko.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am following up on this HFS+ crash with additional diagnostic-only results.

I recovered the 25-call syzkaller program byte-for-byte from the
published console log (6553 bytes; SHA-256
c0638cfd888ce9e61abd5d82ab9afeba058d3b42940b2ab8469d12c4f17abe7e) and
ran it against the matching investigation environment without fault
injection.

The natural runs reach the relevant post-split hfs_bnode_find() path,
but do not reproduce the historical failure. In the current passive
trace, node 3 is created and inserted into the hash, and 45 observed
lookups return it with error=0. No ERR_PTR(-EIO) or target crash is
observed.

The published machine disk image does not appear to preserve the HFS+
filesystem state at the instant of the crash, so I cannot yet
determine the first divergence between the healthy run and the
historical -EIO path.

If available, could you please provide either:

1. the HFS+ filesystem image/state mounted when this crash occurred; or
2. any pre-crash trace/log around hfs_bnode_find() that identifies the
node and the condition that caused -EIO; or
3. any additional execution artifact that preserves the HFS+ B-tree
state immediately before the fault?

This is only a request for missing diagnostic evidence; I am not
claiming that the original crash has been reproduced or that its
natural root cause has been established.

Thanks,
David Maximiliano Hermitte
