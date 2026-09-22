Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE484189BA
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068219; cv=none; b=DMlrhBXCAdleWWvoH899OEXjRlJk/5vOiZI87vjcRsLdJbZIARPkuZLLLi9wO5rorOdLr5U+e+e40inWdnV12sqce3s2Un6lnODYywk53LUWNReFhC3Fvy351RhuqG89gsyHJKfex1ZCP8pSC+ctFnAMAO8OBvjbILSmxOGHhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068219; c=relaxed/simple;
	bh=wkOW124WuFQQCipMuwELLw27Qx4x1bj/S8RRLSKncZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZlhVdBPwtRzdIG8jh2Z6Fr5vOXyC8XiptshQR0R9cByxbzylV6BySdjTaOtOcCtVAE6PPMUDlNZRAj6KkN0HizxjcfJ1LRz+wzUm63h7I4rOexMiguyWXECo/633M+fU9meK0aoJMH1k8S8bC48ME2E40af0qksi83CCGQ4wGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGY+AXxt; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGY+AXxt"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso39358795e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790068216; x=1790673016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=95n40ZP9Z6iTAIldKB90q2CM8xGRzAwUON6dqMEGMLY=;
        b=qGY+AXxt7623LzERg/mEE6+Ms7RT/rJ3c4pQ6qIeCUP/sUVfnkqW3bjYHDjkr45pwr
         zH1JbgnOgOdVafF0n+Bf8PnKUf5wR8pc3AOoREg2mslfPW5YQG9yuLde870ytLkWVTjQ
         JgIbaxrTrFpvt+IJhtMV7Y+SxYGznJNGW27XYYTS5PertN0ho2CZSU0aNLqVzOPMcu3w
         K/aDKu4JlDeFFd4QnFRZTVX9NH3lt9fhDrcLWggaMsnDP8uH4c44bHz75iEhep1s6cDg
         hlqEAzSwHoFO7czr2kOTEZGzfvDfum/gMjMzEzq7zsdG/KsmWoNj1p0RHihsNZXqgyQr
         R/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790068216; x=1790673016;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=95n40ZP9Z6iTAIldKB90q2CM8xGRzAwUON6dqMEGMLY=;
        b=UJ2c9Q4WgZYFngOUwvZ97IRjFFMOgEyiMdjeJXdZQtz8idVZ9iApBQJ7JmFJCS07l0
         YSg1yuLfiq9IiDdtAvaNYWyPLEpl/V9P8Hw6TF3f6N4LvfFZ8Z1rK6TQ6NiHl0YjiE++
         HGrJZVLxdldQfmNKYuxNFaGUv7D6iJKw0O0/4cyzZ3X+gebQyRvaZ3osisQCgqCnh+2O
         t/v0L+jC6ak+9ygA3bqKeZDbIFaWzB1IzCljxI4+UNzznl6rOP2oPbGhxWGemEYeLtkc
         fiS9sMUsibBJ+YSjs5oqMJm1+1rIG7q0TOfLpb45oKcnMpaXbZgLa9pvGDZtRKhkxj11
         ofqw==
X-Forwarded-Encrypted: i=1; AKwUvBwDWNShzrpX+BTVf6wSfqiCQsP2ELlszLyuqgXmlHbf68KfG+xnIhEZvAB1RcNhDfHuS3AwJlWzykSZT0Dl@vger.kernel.org
X-Gm-Message-State: AFuF++mXWwccp/UFKad9UxGCpvDCjEhdeAAg2LNnLoU4U20SXvOQSkgj
	UpgEu6KTSJcCwmRVqNzp7NSXTOolY7oF//IrQP52d7qbMoCRgRgQQb/L
X-Gm-Gg: AYBFou02d380oQchygfWLmQcgogiiijjiTeQ7QwyZWmfWHpAfgnfthLoQOanhduJOik
	lWpAAvQOEpmk92IN1TVO08oIdZ4S5LsScMiBNzjQRsPG3Zg0b5oP3irYi83/P/njSVtfwI4PcO/
	LFw4Rhlxp1QjC19URzDvqlncTME/2+G9Nf/7mZyR1oo/sefd3YUDxLDn8Rw4AB5+Amusc2R8bPx
	Gkc1/tXPsCKCQBy2MZhbaJFR25HCNd+9AONWwyH8OP9Y7ZRh9KV7aAyIdl3V5xnXhz3d7okR43n
	+D93L/1DRw//COeGGHZ77oCSbq+IwySSzasmOKekCfYzldqnJmIaTX+8YCjIHJuvEiPUIjcZ0EX
	vVYOJPbif4eY8pe1NJU1TRktCEXy16DT+/w8G9uTpakVGZB6UIwv/aiJdUmYB0VUii7BVPLNaAR
	il9a8ZhpHf8AwtVdB/rZ5gJyr4LR6yJkmKpAHqFkscJzFBygQtmejShGRbXPyDexn4+VVo6M9DJ
	jBc+seSJSWlHv2nCkjowsItuEpEGblrnKVSnbhBfrvbs6INaj6lFtv5GaNGmdpotWRvL4YTG/Qn
	xDF7
X-Received: by 2002:a05:600c:4e16:b0:49e:8377:c880 with SMTP id 5b1f17b1804b1-49fc574a641mr164997875e9.33.1790068216048;
        Tue, 22 Sep 2026 02:10:16 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fda8f04f7sm57710925e9.0.2026.09.22.02.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:10:15 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:10:13 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] iomap: don't lose a failed direct I/O bio's error
 when zeroing the tail
Message-ID: <arJF9USiUqIEWB1M@andreayoga.localdomain>
References: <20260921083133.2960-1-parri.andrea@gmail.com>
 <20260921083133.2960-4-parri.andrea@gmail.com>
 <20260921223432.GO6283@frogsfrogsfrogs>
 <arIT5A3MR7VtCeba@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arIT5A3MR7VtCeba@infradead.org>

> > Why ssize_t?  iomap_dio_zero returns int, right?
> 
> More importantly iomap_dio_zero can only return an error for a
> logic bomb assert using WARN_ON.  I'd suggest to simply return without
> an error there and remove the handling of the iomap_dio_zero return
> value entirely, as it clearly casues more harm than it helps.

Agreed, that's cleaner than retyping the local.  I'll drop the
zerror/ret handling entirely for v2 and just call iomap_dio_zero()
without capturing its return.

Darrick, that also answers your question, the type mismatch goes
away since there's no local variable left.

Thanks!
  Andrea
