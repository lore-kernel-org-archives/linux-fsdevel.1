Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478423EAAA
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Aug 2026 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786289877; cv=none; b=pi274YzBTl6ekJzmQ2Y65ln0IFw81BTO7dm3YWaX1cMzuDSUzlrEBxzXeNOxy+D7akkk0dRHbv9ZyI81xoXkK1MD0DSMgdptEoW86jn/kfV5q5v2ft9MPWIu1WDtsJtd2Pe+IReSmR2AZC3bbwxI8IXMHyY3vE1vlzmC0gnfi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786289877; c=relaxed/simple;
	bh=QiHspMmrWYR6JR0lI/2orn0XnTH1GeGpZkIk4IxJEEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOCrZVdYLUkMI3OD/vkwHPYYAFJSc72gPLjlvWZQGo1iG7+te3RFDXMN80wau+x86wgokjdiqUC+CAXwLsQTf4A4gD8IfuZZdFWdA21pBQBhMJQwqV3TD1uw/oJ5q31geVC1Qg7/o1ekdm90ZxX2fDMgyNrlnCtCjYmPKz7U04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkwVQ42v; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkwVQ42v"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-495590dde14so12437875e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Aug 2026 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786289875; x=1786894675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HnCiaDhSZ4E0IEu3bcXK+4RsdFqJOB7eO6e26VetAM0=;
        b=VkwVQ42vOY85JVWSgzSTtm/6P+n/bID+roGRqi3Iz+UVtPitl4wAAAauC2m6S1yMS0
         DIE2BTYbNrAk/gE8ugEql1K95W/DQHV4rgEWZyKKBiD40svg0h9BcgMFoPilGIkhWALp
         prJM6rwwFWsE8IxtqnyR07RSeY/GWSAWAjgksIytdrn9ELpbETt3RUS/0SBEnQwXwRvu
         iWsibDod01KUjR9uMTqWjEEoWAXs8EJR6B21bpLfekPIi8IPZHLxUwXuE2iLKReaIxj4
         pZwAzf7ko9qcH8Uhww+tVq8OH4TaPYVU9G4JBCkQTfpwIo+GYdfzWbyi2M1CQHBcC3jP
         R3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786289875; x=1786894675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HnCiaDhSZ4E0IEu3bcXK+4RsdFqJOB7eO6e26VetAM0=;
        b=Z/d78vZpNVPpLN+JqDW8+jbn92KKCGBZoDRZEG33Qc1VImc2tuMOqCqags5e3qHcde
         gilwbmuJeX9/W7MHVGq2mKYktDnfP0upOE2ocpxdahUvOBNkgP+7d3gVBf2K8sme5GHr
         UhzeUa5xaIMflma9x5Tbuh93zY++WtxWy5Z9UKUSJvz1IIvlb+h7SuCgU5v2fWWoLjYW
         L6xOZjvSKTnw5TG9166BX4DlTBrlVpfYxvxQ8ZYb3mFyV441Os6hotOeSyZ2HBY0wO+v
         nKtVMGR5Pt/ZwVkpPJaDytTAzzrLzt+330r0AbfcxP9F0GGHVEWtKzib35GPKUw+G5yo
         PcOg==
X-Forwarded-Encrypted: i=1; AHgh+RqSj69dBd1+DPqRIv43jnxJoB9oxSlzQCzrfKN5YTVoSTEJfHKe1m7MxczLJdIHBGkl7CFXeuUdTd3YHZF3@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl9diFZNel8FiZIVnLZX0kNslAnVRl2ZCDlklGJhylmBo2NhD+
	vCpIJTllsr5g0xzBYq6aQ+mh+vo/rJmxcYYHNT7qOD8ZRajjpRmLtfqc
X-Gm-Gg: AR+sD11Pm8BTV+iEt6ZZWqhwFFxjgUQRZlMpJX2Z8L3kcoHh0vMaUES0ErE50JgPtc5
	Up27qRJNJWGqI92L7v5DzwahFKsvJsNibLBx2CJhHY6Uzs5VcClFqSc09HojY7RVF1KYqUDDYzj
	zNaT0/4MUUhXB0NH86qHfgA3I8XsUtTaLoD7zSVbzwuLFzRLugSC5kfWlX+4NB/j8pm+GFDJnpg
	BJfbLfF4lwT/N5Vfauoo2G2arZ2JfmbjzVNGkxjBUM0UG1AkBZ8XJnCfBYXX3DCEJVGbNUH6q5o
	NAFaE47SsiImWBRDvpylMZ+l8/0/T0M83XkjWLe+FSSDape0qI5i/NGzzRYlC5s2xUPfuKkVMLr
	bvfhv33ECPneDm9eURcH7vmjghSVfmjA1bsKJsddm1UUTXgDQOXF0c6awZNwsLzs4oR28R08lW2
	sEGLORaFBpni1AM6J6IVpVdE1z2CBTnNkd5b6H8c7nZC++N1VCLdDLDWi4
X-Received: by 2002:a05:600c:1d20:b0:499:6123:ac11 with SMTP id 5b1f17b1804b1-4996123ac36mr146379375e9.11.1786289874734;
        Sun, 09 Aug 2026 08:37:54 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4800220727bsm26316077f8f.33.2026.08.09.08.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 08:37:54 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: jack@suse.cz
Cc: aivazian.tigran@gmail.com,
	brauner@kernel.org,
	hirofumi@mail.parknet.co.jp,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	tytso@mit.edu
Subject: Re: [PATCH v5 0/20] fs: Fix missed inode write during fsync
Date: Sun,  9 Aug 2026 18:36:19 +0300
Message-ID: <20260809153619.1888764-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727101509.21667-1-jack@suse.cz>
References: <20260727101509.21667-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan Kara <jack@suse.cz>:
> The series strives to make sure sync_inode_metadata() ->
> writeback_single_inode() will end up to properly persisting not only the inode
> but also all metadata associated with the inode.  This is beneficial for
> several reasons:

It is well known that if one just created a file and wants to properly
persist it, they should not only call fsync on it, but also on its
parent directory.

Is it true that after your patchset this will not be needed anymore?

-- 
Askar Safin
