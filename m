Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A59238D27
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042891; cv=pass; b=WOP0dzTkngKsoInpXbJ3pNgWnMId0tXhaAQ1Kb2JqJiWa5zrSvwmBxcU26a3B2trLoyLqG3YzkNylBVwJGcSYry+P3Kb1tFhvbWTn7LTHKs68xGXRGob+SAW2egwuAZtAjlDfN/1XB14ClzUCLekoDoPUlzcaWwWIegwcHgwPUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042891; c=relaxed/simple;
	bh=w7xoVMyf2fxQGzPR8Ogsy0SlEUtXTDX36yswxAlMwHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aS4+RElczJF3Y8czZBz8HXprOARb7e9Nio8hMfb0BfITlJlPY4q3V8r05sN6RRLoPr37SLAa9xfamO+SHGRU4gc6C4yNncbgyhbuovoqCl/1T7ibMKmeL3H1O9ilEWAk29JLDwz6xU/bK8fXGqTFLiEFpOEfIYMni4bsOTM3w54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJaEv2NL; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJaEv2NL"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4629051c9d1so12710f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 18:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783042888; cv=none;
        d=google.com; s=arc-20260327;
        b=DqefEpyn92rdSVMydJdWn3qjDeCFBJcPxkQJfAVdOe/i7z9XXCyBuqHrZFIPA2TT4A
         ZFZc9R8NE2ft7qQwQq1qH+/79UripBv2Pb3FXTIonBX0dxTT5jsCXib4EVtM+kwtVSfM
         808B4nEUofwBdRbPXvtKiStqxr4vTgwk9IFuGdDaIK2Tcfx5fAhAOHmxk41plR9esnzn
         xIPvI/ID5bJiR7Xm9qsQ1GRRLwvqTWn2Luc1UuZlWFiJnv1u/FRsF6XAZuA1n7ftRuVW
         ZOAXj3hWDUePySGk+C5XeMgDyWIAn3+mSinH67g3B488s/Ty2bGwSp1VdesSsdvvoe5C
         yXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w7xoVMyf2fxQGzPR8Ogsy0SlEUtXTDX36yswxAlMwHw=;
        fh=L0/E3sUzlQQ6IYw5Z8cI7sptVIjZVaRnKfhFsT5+SlQ=;
        b=lg+ujbgc5LPREPruXFVTctpm7WEUVAicDZ6KsD9zHSOefqw+ybrGWIwQw9VumTaX74
         PMQwNQxYHd7LpiKrjwsPcNXilTKgivLKM3KUPI9+6H++CO32drzJGMa5tsbwUGW7JQNT
         WlhgbwN2+OR3XvY2cByiLc1qSGlgTQCQGCBkLmenZAZde8GfLHZoHtxy1azMcaxf82hd
         hLDvfomJOYuXvhNwExgYCMpbffy1QapI4X4+vD1MTydO9zSpi11tjZ8lQuSLHH8mQ1gt
         +HhBHJpFG4pdE0COwKSNCug9/S7J8cpGCf+6IdImzEYlbzWERLdPbskt66PQpTDSFsH7
         o5uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783042888; x=1783647688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w7xoVMyf2fxQGzPR8Ogsy0SlEUtXTDX36yswxAlMwHw=;
        b=FJaEv2NLwVhGqTj8CIOyAwVbwiP8SYVvLUiPoXu8PE9uWH7OTYWUyNvKm1q1q4RmDX
         boYowXT2BrA3SUph/V6feeWdUvW/6vq+nxx/51l5IDJL9N/TPn8qdtsrWv3MPb7waWkc
         8fpiOzZ2/ggPUq6wJJjLF1BP1Q5tx/usFS1v7SWmCJmhoPE2L4uVPoEq1SwONhFkHp8m
         z9+6XA5gULLjQkTMqnGvL3zC3+HFdfuPiWTDHnGeQ4/oPAA3sRi9KrnDxa1OvTjdcs0K
         8WIIMeGBmyAOZp1SlNhD1Fl+hSZSnhaaCyp57XzbQmpgFCGxwASHAENo4fkT48fFfP6a
         Q9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783042888; x=1783647688;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w7xoVMyf2fxQGzPR8Ogsy0SlEUtXTDX36yswxAlMwHw=;
        b=HFJcOZggCSn0uUuTVlPeMybrSTgOtD2fpyme+saoEsy3tl7oAOJeLoHP0ieLN+ElJ1
         7JqhFhkXfNLcCB4qlwe+posR+mo68LfEZ20DRpexRh2GlAwrgnFjYAy1N8i+jtHpIRVw
         g61T8UYlHtDTyvk4Cx3W856IQutvZJnVro5m/moqFLOyac7SPcfKJIcHE+5/zthgH15E
         9OUJqrIpEasJEzjqkc/ne3yiPvW2IhL/xCRNndKE4SXlXPvvBInobPJ+VoileYq45EBw
         eXLUElMEqNHgaNhC0GkER5F9xty3CjZyz89+fps9Lu0LEUgYflCFwZcFPBbnJnKylhlv
         vtnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKkbk/ckqh3V93+jd5Or0SfFa0CZujWtrm3MQq9metI5yDQq6jTotP3ybSEycTHud4t02WFSlv92HnDOZb@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6JxhxUk0XmU/9F6VJl341uQ1nPM8k4WQIQT+oyyehx7SnhW2
	kGThr1RWoSgErMZiy1AnbXq2XgInWR5RU7mRC0KW4WffbRzokY/wcN8avogXuUn/jqWg1/a4JxQ
	bKHz8WaEZiswr58voGfOPY5n7bjmFNkg=
X-Gm-Gg: AfdE7ckT/WgiDL0w7J7rizIRg/Sk/xVfKKagsyOERsu4xPiFEY6AMLmydd0rNF15YXZ
	0sunO3N0lRl4gLJ+RFz74qrULe+eu4PjoU2Sl3fXKj0Gj2wPEQ4RDf+lLt2bsbv1RTn8K5PGsrW
	eQGsWMqUEWjmeTFz9PqqEDYGPezXXLk7yDzuIKFI5/oM5BEtt0fSXWGx7lgjM68+1K8Nv/48ErO
	l9+7T6X4cA4vpA6BJGXOOFUeGfK8BrFTPRas27B9NKDpn5Ia22y8eXK4Vk1cwH1bYSb6DnELshO
	4PKaFzr31Ik6R5vIdap40Qn03jLZOIY0Sk+svQMrzmt3+kqXmNYI
X-Received: by 2002:a05:6000:26c3:b0:460:65dc:e9a0 with SMTP id
 ffacd0b85a97d-477b32c1c51mr10901152f8f.8.1783042888437; Thu, 02 Jul 2026
 18:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com> <20260701000949.1666714-16-joannelkoong@gmail.com>
In-Reply-To: <20260701000949.1666714-16-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Jul 2026 18:41:15 -0700
X-Gm-Features: AVVi8CcRneq-fIwRap2df2tKD9YQ2vVg4344FfSnO7szL3HDxW5fsSJcnqXc4jo
Message-ID: <CAJnrk1b==c6KYO8a6wKzMxXmEYdzdR3AXBX+ePGagwqG3m0H9Q@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] exfat: convert iomap ops to ->iomap_next()
To: brauner@kernel.org, hch@lst.de
Cc: djwong@kernel.org, willy@infradead.org, hsiangkao@linux.alibaba.com, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:12=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Convert fuse iomap_ops to the new ->iomap_next() callback. This uses the

This should be exfat, not fuse. I'll fix this.

Thanks,
Joanne
