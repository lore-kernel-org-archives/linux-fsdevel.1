Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103412;
	b=X31r/NSkkedENaNPPuBUOuK5lQIzKcVJBMoFFLXinNlhL8hFMROrTOkTKNIYE6qrabCc
	 4lAEpltA5P1Scnjk8U+nTpssU6AWthFVKY4JR1FV8S1FtnWD+DAc7I7saVZZv6m4fBM0w
	 5dUCdzLgiUq0N6i0XkLhhvwLqki0gqhCeA+1sfFd00ryR3a3VDmJFhdh8M0nz9Rmo3MsG
	 JuGEiLag9ZPqyNgYjGDW5j0yxpdQOlNd+fPN4cppoG8dAxtJExKFRubbFeMIMEI330m+i
	 ZbWKypaRigt46cfkQZa4nHMUB82YDlWdDE2jylas+u86QJyxbuYaGpZecZ0s5cDIc5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103412;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qQ58TKr8MXey12izNEnvpb2aLK2HSWoN0TjptAHNG60=;
	b=O52BiCLgILOjTjaibjs6IPj6e8lmKipa5UOcV9vb8uoOudMekyuFoZQLFMefIS13rz4i
	 PkmJQmf56pPZGcBRYQxOjV/GmwlXjwj/HJ4VjQg0nZCqwKBD7iIzzJyOg6anWx0WkLg62
	 aQCRcvmXG9O+vyloyag5rvH03A33V7Cx9OcJaoQYqnLsiKZ8xs4HHs/JkRdxxJp6gkdT9
	 Us4ZU1kEBJ66nPnpM3JZXRPTbNAzllT81li2Rv4t0x1H+9Q216vRWqTomI9CJU0vTUp5K
	 uh6bBFjXFAxq59DKNgNN9WDOU6NeSVOsaYuGSm7T9ncqLC0GUOMNn0XpAzvpVhroW6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hackers.camp;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B595606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 12:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B595606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dfbf48b92so354104f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 05:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103411; x=1793708211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qQ58TKr8MXey12izNEnvpb2aLK2HSWoN0TjptAHNG60=;
        b=KoqDo93lRq6YdWBNAjofYCnpquYpeIHi+lL4qHECmrsQEaCmirYCLcHkMNSgV6/8NT
         EEMJvnrc0I1GDYszj/N5iScHtnB4bRPTwzrWvmc7sMLTVy1268Cqe1vc9GUK752eQ029
         +LfBvfzjcCwAZ7qYjUZrD83+OR1n4YHUU2SG8nVut37PtaSK91ha4hsbqGmJJYO52sWy
         vjtaE4gukuM36EqSn7+KrElDDzISUY9u8lLgp4jEXVu/YzyrUk6N/bQjaXQtb4EH2wKt
         2iRRcNc+vkN0zfah2v3ORURRB7/4KHMOb/dXPIISzt0ST2DNcjyDNnB9ruDWD37vs002
         Zv8g==
X-Forwarded-Encrypted: i=1; AKwUvBwLcszO/vPutaJD5BdphwN/aRriYX1iFH4qSu+clkgI6h9GsZdO7gYT87rjizC/gdcEiDJ9p6P3waT2dcq4@vger.kernel.org
X-Gm-Message-State: AFq9FYKaeCltoA1WpSNhVFI/65pRLyuJheDEq9mkJEFi+lxUVa3KLQz+
	H222rD2jIouiKcgh+0DiQ/P5LLFpbC/1KJbhft/yXS2gPXfeajn2iuSK
X-Gm-Gg: AYBFou0IPDNc74VwjsbpVj4GKi4rjvsFh3JkH7WD2xwsWqrEoRL3K+QAveQwAP6roQM
	UWYJatGI+mLzbE3GCxVFC0dfnPTkUcGuhL7MOC+0VCuhvs3qCJ8ksSd/6ohdx5UDThpPbPjCDKn
	T+GUg9ZyIaMno9tRrqd9RV8l9GfLOoFnOpO4oJbhCBefW4UdAE3JM1D18vC5cBbXhUPrMbEG4Ve
	g1glqGhCrZ8IjtWCbFOuXQMjrqC8Xlk8ifJfBBVZBlzsJbMtCBXB0abcc31RwUsbiDuWpuPapAt
	ItIATwsKWJY6JlamZ/yJdnzMVwHPLtb0zLPj5SQkhmG068An8roEmAKjqpPd57DhxUVHToCEeEQ
	0zMmLhM0yYwLxjyv5ucSZ2gswnry2KIuR6gX2KZ6215NjcaMACn7syz8V3zkZ6+EAjxNm8NLiUi
	vvfHBTtwR9RpgjTnJYb36ZQ7EFsrRg2OPjLFSo+dcAIT8jSqbuaYl452R2qq0mcBlCCFIKePXNZ
	PcdqbvzwvKh3eYxJRZa2iWV/8hCIt8o9TP7vW5IFc3wdxf34bfz3tM2kLcEjsbBzlqzj6Eka87b
	tB2MqqYy8Q/s5+CooA==
X-Received: by 2002:a05:6000:2905:b0:48d:f14a:9186 with SMTP id ffacd0b85a97d-48e3eb97829mr22056835f8f.6.1793103410734;
        Tue, 27 Oct 2026 05:16:50 -0700 (PDT)
Received: from spartian.home ([2a01:cb1c:76:ed00:602f:c5f4:d108:b925])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm21108892f8f.7.2026.10.27.05.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:16:50 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: jack@suse.cz
Cc: brauner@kernel.org,
	willy@infradead.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	aurelien.desbrieres@gmail.com
Subject: Re: [syzbot ci] Re: buffer: warn when a buffer is attached to a second mmb
Date: Tue, 27 Oct 2026 13:16:49 +0100
Message-ID: <20261027121649.69819-1-aurelien@hackers.camp>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <a7h6k7ecnmnj426ss45fqdk2kjodrjurjpwhcwao2bjkw7tqtl@qghx3vrx5ber>
References: <a7h6k7ecnmnj426ss45fqdk2kjodrjurjpwhcwao2bjkw7tqtl@qghx3vrx5ber>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue 27-10-26 13:10:55, Jan Kara wrote:
> Woohoo, great that we have added this. So now we have some filesystem bugs
> to analyze ;). At least in ext4 case this is a real bug as xattr blocks can
> be indeed shared among inodes.
[...]
> I'm not sure about the FAT cases because directory blocks where this
> triggers should better belong to a single directory. So it could be some
> race with freeing & reallocating blocks. Needs more digging.

Our mails crossed; forget the pr_warn alternative then, the WARN stays
as sent. If digging into the FAT cases from the syzbot repros helps, I
can take that on; say so and I will report what I find. Your free and
reallocate theory also describes something beamfs could do with its
indirect blocks, so I am running xfstests against the warning on our
side first.

Aurelien
