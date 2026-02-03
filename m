Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D160338931
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121581; cv=none; b=EU8u6Vzu/NCGnphaeufjWadSkjcx1ZnJl7oWMW9NBd0WJysAUdNDoUWfJzrhKGn7hH6Fz2ZBx4EqfEzlh8TIqionMyy+SDVPbEcnGhFebUMMD/yNmyh9zle7NBst8kUY88g1z66JAwHCpSeDANDy+bfBrZ//jvQrHoa1/pP4jz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121581; c=relaxed/simple;
	bh=VCQKXK/b6w1p0rJZZ0YdDkePSLgf9Ak6OzkldxZRzdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNb8mgZRF0x3UpzV6BvhbSTCLqndkV03DV69saJ6IYSttmSZGy4m74DUhTIHoDsTZfURmVRSKlwZaP5MOXqfzurONU1nrHs3HCk4hefnSnHPdyPy3kujVktXryIMwgHREil97x7da4l4n/NuyZ2WZwI4KAqfTBwmd16nK63mYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FauuZ3H1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FauuZ3H1"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8850aa5b56so893592966b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 04:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770121578; x=1770726378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1+6Ooei3qcktWMsNzPcdbmfIrr0F/PihFSzcD/XR6E=;
        b=FauuZ3H1yH9N03ATMhKz/QNUdiVlnNlGyCdhk2LNv46+WnfKhyi2oTCP/IKljsYpPP
         UCXR0nmEqbdgv6LtHEzCSor5Mfg/xpdrjWEliR272hp01TidLlcFU/0J7qshXkjG1rSO
         0kpVoust/jomzT9Cl91uObSkL9urO5dLooaVViDGr0Sz29w4kR0XbAgwAKmGvWjXLqZr
         bHiEd4/ixJUPnr97Gi6ppr37PQARXNeAS/P/Lqyqa8WUi1F+itsntRL19GlkEwVreLwP
         cOX2wARAk7XARIEhj8ZcjsvR/rcu/DbEJlBpJn2mjopLlibj1n+uVVo2TbzX+Aq6AncL
         MnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770121578; x=1770726378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z1+6Ooei3qcktWMsNzPcdbmfIrr0F/PihFSzcD/XR6E=;
        b=SgwVBn/jTUvxi5rfKTKM2Zz+SmqvLpGMT0iEFIXEyUejosnnzhr8P86yvOCxcsA7bx
         wraSkvQdPLkJMiX31tlOsDAvGBYXCGdSnJhG7MbcpD2pStSy1FKVyQ7mpERyW7MSwPut
         IL01ouHYNYEBMC4ap52h3uh73vtisYB6f/Pdn9e8we+6HooxhtJkM1C9Ey8wDeL0uBuq
         meCxn3VfnGb0v7PN3WqVywVfhPB++DohTsV3hvAKt3cj8FNCLkDOzK4I/e3L4aYV6ZYV
         xOoUS5dnptofYNhk+6iYPTxRQMaGbVVL96EAI0dC6cLEfQptrvZRNordk9/V8awOT7Q8
         1xrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZlFwhqlBgvl9zRJFJbrupvQN7LUGUwA5WTIv19fUe41wyii9vU3/w4Wrnavi7o5v1fPcYT1+F02zvfwWd@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTpfKDCMTHIgSlTrfQt8gjl5rr4k5Lnq39C+7qLmJYxRtplkS
	GfrElsN8deexlFM+wrvT1xV+3AHs9iuyWbG9RJd4PvwY8V54bErUxY9T
X-Gm-Gg: AZuq6aIYxU0Fxgyo95O1u8vVXYAMz81muFI0lKtFo54/XNhzpTlObUEkjaVNgvR9YHw
	gMNJgcTeo4Qijf4ww9Mkad1P6lYonFD1p/8MBxBxIxC+jS97IwYyu16Jl5UxW+p+vpWAvAxUruA
	pxPf+vq2ZReNPzjSndytv5dVZm4XjrkNINH9ezqjR4NJrjVlEH4SPm8Gyz12wr2hCj041dRD8FO
	sfy9+uOVe5a9C5as26DW9mYmL5CitoWaaImeKpj+cLeaP9cJvn5OIWmiopspV8K4X8fvQxqa5X4
	J9UPPRDPkz8OCcaPqUmAUSeaqQe0qhdRQdbqmuV31XyQl1DJgvxaZef/BGRxTbU5JbstdtEdy7u
	IvoyHq1T2FWf/I5ta8ildgofyRfLca1SjFBi+al5r+R74GaVQzVic69gMawchJfaCa/sjDvqsKy
	dbWA0oLRA=
X-Received: by 2002:a05:6000:184f:b0:435:9d70:f299 with SMTP id ffacd0b85a97d-435f3a7e644mr22293614f8f.22.1770114553095;
        Tue, 03 Feb 2026 02:29:13 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-435e10e4762sm49060917f8f.6.2026.02.03.02.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 02:29:12 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: dhowells@redhat.com
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	cem@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	kundan.kumar@samsung.com,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	wqu@suse.com
Subject: Re: [PATCH 03/14] iov_iter: extract a iov_iter_extract_bvecs helper from bio code
Date: Tue,  3 Feb 2026 13:28:21 +0300
Message-ID: <20260203102821.3017412-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1763225.1769180226@warthog.procyon.org.uk>
References: <1763225.1769180226@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

David Howells <dhowells@redhat.com>:
> Can we make vmsplice() just copy data?

vmsplice already caused at least one security issue in the past:
CVE-2020-29374 (see https://lwn.net/Articles/849638/ ). There may be other
CVEs, try to search CVE database.

Also, I think vmsplice is rarely used.

So, if you author a patch, which makes vmsplice equivalent to readv/writev,
and mention these CVEs, then, I think, such patch has high chance to
succeed.


Also, as well as I understand, this patch introduces kbufs,
which are modern uring-based alternative to whatever splice/pipe originally
meant to be:
https://lore.kernel.org/all/20260116233044.1532965-4-joannelkoong@gmail.com/ .

I. e. these kbufs provide kernel-managed buffer for fast I/O.

So, I think it is good idea to deprecate splice in favor of these kbufs.

-- 
Askar Safin
