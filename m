Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2923CF699
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102622; cv=none; b=vC6Vkq/pG4n05EGWn2G0f5pI2/Nbfh+v19guzvPI+pYHmQv6fyvIetiUu6sn3PkCTrrx8ZaP5flWDPBXnfvNKTvHB5a3bwP1WjEqqDzbVqdlnQCskN2J3gPB3ipT1O1ZO0D5wLVYe9YupUg5XSi2Lv2UDlpwyUi3gSMyUKN+Zmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102622; c=relaxed/simple;
	bh=Ey1dVK+mA1HsYVtOFCvdCUUmzc/P02m1z+8IiV9BcnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zzy2LDyHwkWtfZxDtnl8myABUQc41hztTPdc2PNw74W9PNZGsoEmjk4gisTi40FZ8409Ip4/4zSbX5M/sK8XvKhKejLRbgkBBEPPreRLVzLYmZLNJBTQjShh7AM8NyWObZiWbB0q86W3zCGbxbJr999YoDiJk25BJEZGk0sglY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIhY44Gg; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIhY44Gg"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4ad9so568705e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790102619; x=1790707419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2l4JRHC7Rw+pqUP1HReA75dDASuf5PmXyxwWG+odoY8=;
        b=WIhY44GgUthjJ87mJUagfWsiJbK1+4UPAYPDP5yf/F4dFnzRJR/V4NQZg0m1Kv9kRH
         3Xfw8xRjWa+h2i4KdU71NHILFbpsoYTjo8/995/qPnhLb2utzq6slH2c6sNT12PpgHfA
         QIPtuW8Err3r5fSEDA/uZ6qU+O01wmGmuGu5IKhSXfTbHne9qVX8fQip8FN07atJPfga
         MwkEbNwz1Szq28MumFLMI+AVr3i7n8vLnK4R2onmvxxZBJdD8/X3uf8oLtQSqse3/5Gj
         +gkzGmtG1O8p3GTHf3E+nE5yc/j/1yPV1ZvVuMpzWMLWUT35KN9DBmmEsLAuImAbgBbh
         XKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790102619; x=1790707419;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2l4JRHC7Rw+pqUP1HReA75dDASuf5PmXyxwWG+odoY8=;
        b=J89rgIsLs7EWG0NF3G3/SHXwI6+gHkPAke18Rz6/h03l17Zxzm5pnZmrMkqWiWLKiI
         y17dlEVPkYEMMTX6RuF3kJwTEzMYRkl1ldGpzzA84NO5aFXfbjijxpto6Ewatci6SCSj
         MAu7aMdFrGL+LEHpeCzD/TaGX946Kr+gGFaOO6KvkI1rDMzBg9BgvXP/as/34v7K8Zw3
         6fttwk3TIixtag7MZDGRJSc4JSAGPIFk8ttfRVNKE7VYSQOl3BYk1eHvV5mB1C66x+G7
         GVQgR6qKsyJYGlAMa/v4aImRsruFOgISdnrOjl6Bs/QU8E1TLPIUiBPTkIuOeGnZdMxs
         QWbA==
X-Forwarded-Encrypted: i=1; AKwUvBzKCI5zI+vSBILE1ycnmaWVmhDpAFMSAXj1CicpnlBnpX9vrwe0YjtXSErwPy4gfwNHHS1FR9n3Vi+7p+B6@vger.kernel.org
X-Gm-Message-State: AFuF++n8quAXxeEGwHLrL9cRSXLMOGCfkdvVNe0IonclcrtwzCNClmPl
	G9AB3x32GlPupGCXHEeWvurVMzWP6yx9ESsVaLLxMyE21YDxi4MksjOu
X-Gm-Gg: AYBFou2znABJjSZ7sbW2Ns4TaxdHfIhQec37L9ksSgoJmIZ5Bri6o9oKCLNtIo2OMFr
	v73dX39HtXHnG3O6AJ1BwJQgJ4mkluQgnRD7cVbpA24qeCDWivFfQoOXmqhnLT4UNUx4Y4NvJb2
	IyvenJ1ZMPJsWoXXmEzsTKUyAoavFVm5YRO9A7dWHEk7pMEXwpV3KYhx+PcxoPVh8lWIHWByGWY
	DUle3wnjOA4O8pK/d+otR0uNKreraojOLPln7YcpCVvFi4Nkv0V1ASmSjXscjCHZ2DnZsg5jTUE
	jStTsmR/0W4MLtzoOYmtBesKzTVDpnUAoisQF+kdljpa1zXIQTe5STKoB4xUBgGz7S+5oya/3L2
	cLSyTz0OvBvunsWF7BQTlZs/1PdwxJolK6P/IB8FJfl/SfMDRjNGQcUXIgXeg+AKd0sr29hYceP
	eYTCMWcOYnPQXTe25Ez12OIguty+0RKmOzA+JChhI6FifanP8YnMN11MYGpmQdJ1HWGr3M111Rq
	uLdYMOSXqUT3sPEOmj/YdKO0L8xlk5z495QwFFYKhazIR0=
X-Received: by 2002:a05:600c:a06:b0:49f:cbf1:e765 with SMTP id 5b1f17b1804b1-49fdec980bamr2359185e9.0.1790102619110;
        Tue, 22 Sep 2026 11:43:39 -0700 (PDT)
Received: from andreayoga.localdomain ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18093csm13157875e9.3.2026.09.22.11.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:43:38 -0700 (PDT)
Date: Tue, 22 Sep 2026 20:43:34 +0200
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
Message-ID: <arLMVnDWlXPD1iB6@andreayoga.localdomain>
References: <20260921083133.2960-1-parri.andrea@gmail.com>
 <20260921083133.2960-4-parri.andrea@gmail.com>
 <20260921223432.GO6283@frogsfrogsfrogs>
 <arIT5A3MR7VtCeba@infradead.org>
 <arJF9USiUqIEWB1M@andreayoga.localdomain>
 <arJ0eljPZIuj5PFD@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arJ0eljPZIuj5PFD@infradead.org>

> Please drop the return value from iomap_dio_zero entirely.

Done locally: iomap_dio_zero() now returns void, and both call sites no
longer capture or check a result.

Thanks!
  Andrea
