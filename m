Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F842280317
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049385; cv=none; b=V9KYD65R+yrjFETSyLXX94FeNVGRRkYTg2P4f7sVfFEKuP9Y/ZfJ53bzMjczv3QUBj0YeDlhgGsK67zMWLBgZUynb5+ZxIi2qla3pfA7p1zEEGs1DLzjvO3wj7KDu7Gsz5Spn670WWgfjPDLe51ZO2a71xGd6COpbv8PV5+rUIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049385; c=relaxed/simple;
	bh=tDhcTjNxU+xemZl5KpnqLTDnF7wvr6XCIXBv9yqxToI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkE+rm89fkeI8ztPj6ut9oMB3vorfiHr453XXjR/UCzzoWnzG3iLZ8uX9lTQ8gVGEU4WQwfyp2Lw4OAbJpiApsds+zjvs7YJDx880v7j/kxZWREPLgglr2KMPIqjoy1Qeb+WKdYe19X3gE3NignQQfYmO/fFUjjIVdu56rJEWtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdhhbmEP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdhhbmEP"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so4059281f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 08:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770049383; x=1770654183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYWBbcJbimtg2GEdnq9nutfbY+5nFxABvl27nUuJuWI=;
        b=QdhhbmEPzZz7TSuGedS6jyuHGmlIDKMfxwsDcNcBayqPCeYyTiwHmj2nxXgjgERhLg
         O2HXd7pP0zCihlrGzbjdYVxpmsxlT1BAxzTEAp5fhZi5As3n4DH76r/RnbDmYauDfo/g
         eAKM+LDmIQ0l2U0bDIwOvM4QUPe69nEFbsjC9vUSXIcN0x6YK/p1C6j610gqK0s4cgtx
         cFZ5aWwI5vF0mZWHIW6x70OVCcwoQsmWG8s8WbuZda7jRtca/LYbd9mb1Dfk+ekc4v8p
         cEIhIFR4qYnGpyaaUEFzlxPii+4TyeHDOp+aVIlfb7SNqSolV7GMInRu5W4I5305aiCO
         BKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049383; x=1770654183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iYWBbcJbimtg2GEdnq9nutfbY+5nFxABvl27nUuJuWI=;
        b=NBpTr/mZBs6QV/tRTUPHE8ITVPi5yt3tVqUrOMGd+37mbz5VFvGgXI7PLMywMJOY/M
         JebhzTtFZ6+Tr5ZLyD+JVee1e+H9KeOYH8oURM2+jKjWXwi4Q/BRSdUQEa9AJHtm/JHe
         ubBSwzDhu8pnnO/okk9INUbWqr8twLRd49ej331mKOPQKDeho+ltuLqEchNj5LA9IKRI
         7ZC/8i4vVPpx6MNEhIEknuriFw4PN+/VCY4WSYLZJLcBCmaTDCAYBuA0s81PjwW7UEY7
         GHeqwvoeU2VqpNNB22WoaXnDaSUycEJNQ7X9k0wIYTuMTVfmVC/61E4GH3KU8ZphlBcQ
         5BHg==
X-Forwarded-Encrypted: i=1; AJvYcCVRthAMWYKwLL9JPI+wcpHbOa7NNbollGjMeJ12JyhuWuXPHkAxEqNhLHzR+dYHYoAW1sV2yMglDyPuQzfY@vger.kernel.org
X-Gm-Message-State: AOJu0YwIq2JCO2SBpZcvXZ0LY5LzDiQ6wyRDiUal3hgynwyAilNTKDWl
	FFlk+cFwqdmd5Wr+lRwKF2dy8CVB9EmnRCu60F4YedAjGOwJlPlzTdSR
X-Gm-Gg: AZuq6aKBjB3mR1ND+2hxSpa8kZ9muI85QPNmImZTWzHx2FFkRVnlRZ7pSa/+WKA04Hz
	GUZUyTSr4fp8JwAUvEs73TqQk4jO7QHqtQ3Tb1Fl0nws5G2rGYPXUiCw59jGoJJGdf9511+ivPM
	feUMsnmVY6s/z3vWaZEEmn3i8st6oTpgVdsWA52M147Uk0QgI8q0DV4MTUFZB/As77GUqSZAfUu
	PZf87+Hquphx3sSDqsmcn3PQEOA5lANMG1K4W8AvQEGZLTm9zD9yQSE5uCvlvIZVHIc1ODaKds6
	9r93dbgWNw+lnnSR7PkMqvuKmm+SFXSZ66PKofI4PBtPgA2vFZnmvO5vKMLvezx+xqRloefhLAk
	/iG3qyvou+dIqRBKpKLIbZANki+NAGb81+LBPV77RpM8/hwOytBSfytT59UmfdKwG02cFLJUQps
	ar2lFGmHU=
X-Received: by 2002:a05:6000:2404:b0:431:9b2:61c4 with SMTP id ffacd0b85a97d-435f3aafe61mr16769082f8f.45.1770049382376;
        Mon, 02 Feb 2026 08:23:02 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-435e131cefdsm45989708f8f.23.2026.02.02.08.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 08:23:01 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	lennart@poettering.net,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH v2 0/4] fs: add immutable rootfs
Date: Mon,  2 Feb 2026 19:22:57 +0300
Message-ID: <20260202162257.2384773-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian Brauner <brauner@kernel.org>:
> Add a immutable
> rootfs called "nullfs"

Why not fix pivot_root instead?

I. e. why not make sure pivot_root will work on true root of VFS?

-- 
Askar Safin
