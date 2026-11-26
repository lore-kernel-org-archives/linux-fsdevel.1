Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795676256;
	b=rSAUEmmGvPFnV6aXe9lg5qzpEl068K70/+n09GZWSmbzf7zmfhaDYM65EVOklCDbyBnz
	 Jg/ju+baMuZsrGjN3jwZPgYi8QXj6aRd2xffubGpWt1k/fO5dmV72acpSH0Cau+S+4Iy5
	 7K5yoEl2HB/fPuhu2ecMpSrLFK1lEE59eZcXJkuQlJr8CRg0oKuyUehN59kcjNkR+bjgR
	 FWyNAZILDBJYB+qfHK0XG+OWgiRvDdC4QmmRySmFPzJSFBev2Tj1zdkhOHnh7jhktprzn
	 fxLSVTGgtZzRSvif+i83dgMCWnxsECyohWvnbWQTLYDXFEQIzTgI3/GW8O2kfD6VpLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795676256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OV8ZfQ31h6oUU+BkfuJmbyYts6FR9jN//PpBfpjFjkk=;
	b=vBCFcCxhYLSXQ7S0KC04eKd93mO6H5d1YtmQvYot7WRGVJ+ev1p7IDH5b69jQo3Q/Pvg
	 JwPBwNOewoGsejN/FSJ/2vYjWexm2MYrwqf2EHSBsKB+HQekQaVGFNEWRQCf4OCfBDf2O
	 HYwwzttuc2sIuAsLK+1hVaDbT4rRNHAmCMeJJtDR86J8Ni+xjZv5EsivtjF/7dw7k1/q7
	 +Zy3A7F4015ikKmUW1+RH0W/lM1l4KxAwsPsQ98+ZmFQVMyltldiYho+OXr6RTvolBxLJ
	 eoS6eaGe1yU6yNCTTBO30LfUIpLFwWFZ7eA+rWaSSnE/5NCiDA7AuI0x6MlP2lQGr1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aLyPoQK0;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0761606A329
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 06:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0761606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aLyPoQK0
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso3011282f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 22:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795676254; x=1796281054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OV8ZfQ31h6oUU+BkfuJmbyYts6FR9jN//PpBfpjFjkk=;
        b=aLyPoQK0rgpR69rohkQGgoN91aG2cqq3/YzzsIyl3nNXfp4bgeO601Kha158Zmd4HI
         9mhN3S8wvRa2qAX/TTvCznFco8BpKI13TH3n39U61wOC/Xd2iITSsdzaT4nu7r9EAUIG
         cuhsTECT52cfxSTYDbi/8kUeGwsBqX27CD7LXdjNLXFuIM9G9So+7Ktm2q8fSO4P0iQj
         sC1LBkT+pBw9TBdzUae6YA7k39kkPgtsEUZLwUaFnqxB7zJP+aMsap5JS+76NkloZTdb
         bAFSbRioJxtCA/QUp3VBsps63rgGUUGWzL4TaZdjerL94n5z2p3chZodizmU1A6Px957
         kCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795676254; x=1796281054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OV8ZfQ31h6oUU+BkfuJmbyYts6FR9jN//PpBfpjFjkk=;
        b=NxFLxSVCcwvgGp0KSGxB/+WjCJfhmHhmlH0bUIBAAhSKPeth1iBNVtkCmqbudA/r7J
         ib1ql45pUx15I8nZHDNQZfWS06RX9F435RJLRx7zKoCnP6tBwkh/qRpW9/XWooNOD7on
         1ccx+F1Ew/9eO4pl7B7QXMi/VpKpgvEqoWbdlKxMPOA8kv5l8ymocxDt0Un0/HzgYDPq
         nnajijCldR/WlT5dKZUlAMdSwD9wY2Ujja+MjVxppoRCb3072bX58c7LKVOFP3fG904U
         nfCVOz9TXtT837iQt2GKmg9SAKKDi7VBUkfrGzbuR7KJb7MHUpsc9b/NoLLOL1+PDMUD
         uLrg==
X-Forwarded-Encrypted: i=1; AL+hErGgf+ZRJYFL0RSoRvnzlHgO8bJQDMeeYiHjoegFWVY7yru34+sCtt7u9bqylW72uwHtQTYXaJEWT/oOQ4KE@vger.kernel.org
X-Gm-Message-State: APuU4Z/d+2Lr8vjUZxSqr0YAt3K4qsViNxHJzAelivEeLrlr0TJ6kW35
	ILv+vWU8FS4ZNlxJopqNoNFBQk99ZDqvdXbCU7hJUTnUZAy2twqNfZsP
X-Gm-Gg: AZFdTZf0BMncB+xoJJb6ZTOBBnp0Xnp7hyy/WO4yhC7cGNz4A838f9DDWl+pU154up9
	1h/84ZYJvw0PTbI8Xrww/5AS9eBhG3igFazkzDVKhcuLVp85AQJCJHZrSawXCBvHKjmaBwsTBPc
	BfB1SBGhfjAZRpHf9PXCNsdO+ayw6BFBfukc2DBNu8zdW1oUC73uifQKDT2csucOR3Swee0Ry/X
	qr86VkvNMN8r5ja9rbI0Oc9cBWTvpRvJRc8np3Jz6ajNJgddqQrSQSaN7kO2dkWipsvql7ZWGEv
	x3e27fIaeoxejmeON+dLDZswNdrqTeXRj8pNxVtH03nHVtgJj8EzzPcLKHWIca/IICnmxQQ69ug
	Yr4/P7fHMG4517xbvr1NhCLeQArGrjw9rsy2bnGtOw3aIgdu3UmYMk1Ru2J/yqRLiajXLhckdhY
	m8fOCKdNmRkx0gDAUcgoJnw/O1xTDxaFyIHqTVzcyoYnwefxuhYPTeW7TA21FuZl76jey3CCqJa
	bCdcK5lh3UdzCmHSiAkXdjKWjjqhUhPdSc00itXf+5Lu4gkdoYyicemiarl681chDaMHpi0Rrie
	uUohKbIeRtSjFeTdWMdfuZuKCA==
X-Received: by 2002:a05:6000:25ca:b0:4ac:7595:6f67 with SMTP id ffacd0b85a97d-4ac7595721cmr33965238f8f.40.1795676253907;
        Wed, 25 Nov 2026 22:57:33 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab658e2d55sm38636374f8f.5.2026.11.25.22.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 22:57:33 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: josef@toxicpanda.com
Cc: James.Bottomley@HansenPartnership.com,
	andrew@amutable.com,
	brauner@kernel.org,
	jbingham@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sergeh@kernel.org,
	taherafahimi@linux.microsoft.com
Subject: Re: [PATCH RFC v3 02/90] Documentation: add examples for cells
Date: Thu, 26 Nov 2026 09:57:26 +0300
Message-ID: <20261126065726.2646029-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-b4-cells-v3-2-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-2-bc9095937a84@toxicpanda.com>
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

Josef Bacik <josef@toxicpanda.com>:
> +   pidfd = pidfd_open(cfd, PIDFD_EMPTY);
> +   pidfd_configure(pidfd, PIDFD_SET_STRING, "exec", "/bin/convert", 0);
> +   pidfd_configure(pidfd, PIDFD_SET_BINARY, "argv", "convert\0-\0png:-", 16);
> +   pidfd_configure(pidfd, PIDFD_SET_FD, "0", NULL, in_fd);
> +   pidfd_configure(pidfd, PIDFD_SET_FD, "1", NULL, out_fd);
> +   pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0);
> +
> +   read(cfd, &status, sizeof(status));
> +
> +The ``ids`` slot was left empty, so this is a one-id cell.  A builder without privilege
> +does the mounting in a user and mount namespace of its own, since ``open_tree()`` with
> +``OPEN_TREE_CLONE`` takes ``CAP_SYS_ADMIN`` over the mount namespace of the caller.  The
> +cgroup has to be one that it owns and could move itself into, such as one that
> +``systemd --user`` has delegated to it.
> +
> +The new task has the three files it was given and no others.  There is nothing to close
> +and nothing to forget.

You gave the task 2 files, not 3 (in_fd and out_fd). This is obvious mistake.
(Text and code don't match.) Why LLM did not caught it?

Also, as previously, I still suggest to open fd 2 as /dev/null.




> +Binding the node of the host's ``/dev`` does not do it.

So host should actually create device using mknod? This will be problematic
in case of nested cells (i. e. if we ever will support nested cells.)


-- 
Askar Safin
