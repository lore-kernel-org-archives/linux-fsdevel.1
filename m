Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D99407CCA
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783726990; cv=none; b=Bp4/IoQAIzCL5yEbQkyO0Su49tBrglaZIbWr+g/43fhaFJM9Gw+yJ62bG41LPhJVoxoNcA4fBkwAFkBcoOZBoInhKZ3FhmP+gzFRz0zbEHJh5Khe5S7/V71i9NO9WXb5pliWkME/VA1v0nO+sm5z0OhFOTIBLqfX16wwiOlPfjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783726990; c=relaxed/simple;
	bh=hLGg130yIZeslHGPCdPPMzyX+FW2ovnKWvKdYHLDFy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbL0bRAKT4lYymPPPERqvWYUYqneLVx3dt92j41oxgE9st1MxhKbPZRsZu9ZA23xSQ2LCsfnKyyQjCrGKKGH3XvmQAP/l2lNV0y/95MyFNi/cnQwiLTuEiQ3GDSV7bLZgt8iG9u5v7RNq9nZkF/5HB8bBE3B+Q48eZE/YindxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0LI/J19; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0LI/J19"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493e4ccccc2so10305725e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 16:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783726988; x=1784331788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hLGg130yIZeslHGPCdPPMzyX+FW2ovnKWvKdYHLDFy8=;
        b=D0LI/J19bernF+bwd1nvZQAz9O5gzKbTJ7zkuDnyRBk+VpqufZox5ykLSQy/1EPYFv
         HDIwVQn9aSqxFn7YXANKTakF1tuZbWv/HCK7gerZvRM6dHoIh0b7+7k5lsvRIs+kadcK
         OQVROC4TXfXw1e7sS66hU3Dfqakge01U0tatooDQOaQwaspHtGu+2+ZC7g1+sCbJnN/G
         7QHq+zLxaI1yMhMEnqUht8NUcCS6hGUe/l/+WPUZsy9mv2SxoPCgfFeLvAyoZQmaTk7e
         MYE+D8wloVO0lmMvG9HHB/P+GLgv8VlvDfR6c9wG1CYMxUaxK2hKnmMMpQm0R87lQ1I3
         4uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783726988; x=1784331788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hLGg130yIZeslHGPCdPPMzyX+FW2ovnKWvKdYHLDFy8=;
        b=cNOu9rHSFMiw9yW0Aq65+cE55mXfxPYzYIJMVbe5jJuxcSGhsZ0fiDPFBXpsCcHypY
         irqOWdYwt+A8bC78k65XsLN0snfJ6UMdpnonTb0iry346w+y8jEmKQ4j3Pi1njrYunJ0
         2ycQWAmH6hw4DiEq1fdtUsz1OT5J4TsIWON5Stv7vwEASwnTnIW/UGEMhTgj/6UVQG85
         fUbMrkPbwASdbdoI3Mx8k4PyJAecJGdsmmECwPkm2B4w56Sphi6sWaw556FT08T1y+4X
         euYcdYOIITsWLUcOqBQdJv0sHUp/TW6mUfRSjbb6En5OWRCDuQxd1dIvem7bVi7fLpom
         xIVA==
X-Gm-Message-State: AOJu0YwshL/tG+vpS/gF1JDrYpnyURnOJmwFdhckLq34TTkMqXYKWhq6
	ePdKuE252Tg7bFuwaBEzrEUvS9S1dNfdgAeOGBy6uANCrY36gMFAhWVA
X-Gm-Gg: AfdE7ckn7WJzjvZA5dJhfksVhk3acKrp3APyFjZ3X7BBBh+hF8MiyTcphmACaZu2qWO
	OW9EhmLpBmGEK+PVzCn90r7As4dB+x+NgneAeSGE1Yosz1A7mP+NTbuM6qCxnq2QvHkEoRGTbOv
	YV4wH7y1N96bqlMuQHIHz5AyMurjySNPDDpAx8RNvxQ3dE4rnjeyFh/ob3/KCIbA9ajPqvjX54j
	TwS9gwQFsFniFxu6TW8DMGbgqffVLmP6DY10Z/B1Pli2N/Jf0cWJwkMvbPSoeUZUFbpstC57BQp
	93WbTEceJ/wM87sK0pCA8SzkuOUQVltFtGX6POlGbQMU7PoGw1TDM5uIIa84jy+L75s4gj8fVKp
	xdyDJMepNvzZ8xtCB14brMtHJ/WvMkfYDJUhyMDy02Dja8PBeKhHagjA1Q4vfr0F4E6/5Ey3BRw
	jsPSRP0euknVQ=
X-Received: by 2002:a05:600c:8211:b0:493:a5da:e5d2 with SMTP id 5b1f17b1804b1-493f8826f64mr6756675e9.26.1783726987770;
        Fri, 10 Jul 2026 16:43:07 -0700 (PDT)
Received: from user ([197.46.176.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df6d9sm189342285e9.7.2026.07.10.16.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 16:43:07 -0700 (PDT)
From: yahia <yahia.a.abdrabou@gmail.com>
To: willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: truncate: exit on empty batches in truncate_folio_batch_exceptionals()
Date: Sat, 11 Jul 2026 02:43:05 +0300
Message-ID: <20260710234305.99362-1-yahia.a.abdrabou@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710231930.93427-1-yahia.a.abdrabou@gmail.com>
References: <20260710231930.93427-1-yahia.a.abdrabou@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please drop this patch as the condition
i was evaluating can't occur.

Best regards,
yahia
