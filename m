Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0FE4D9558
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850609; cv=none; b=HeTgRBmk97cm0kpBkuSZxpJ4Kbq7mOv3tPr2pEDfb3m82Uwcvr66euE7GbSRQDbME0b0HZAfGtQkzWZwa/Bct1VFSQ20WbmA52Gy9lxsn5kp6bI4Bu+3DG3P2vnz7Vn3PqSMF6/nL98Qk9e1RMHpd8pzOVsvXbgtneJsVrodzGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850609; c=relaxed/simple;
	bh=EXf96x2mt3+0rsT4YN/N66i4e7zxAljxAJ3P6tiYQCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rpsa+054fi1T9eJn8r/28hdkxnwY1TvujRZamU7s8q8oKTLAEojYK2ncJU37SyK+wam9/wX1qh0LMwz8DCtpQeFUigNrh7RwLx6/ZzfAIbtGMXU7FnGs4iMHqXd7OFOFO4NJsI1hvS7MW9gxIjlEWqKoTknKeiIOoaiaMY+nqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8A4jqkV; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8A4jqkV"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0b25dso40619745ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 03:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790850605; x=1791455405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J3MX1SIOE23Q6Knq+G8g7lwc8PeLBc1oDxDbBbgHkhA=;
        b=c8A4jqkVpDA4WT+qhiz9NJzgA22yNOZYPL2Hz1MeujxNcI2tUfKFuV9gVzYU2u4OYi
         tFEw9N+f2NWXzUQPI49793UI5x91APT0H3GgZmxhmEbcElNo+AcURi1+xhpxNcY41GM0
         KT7sgGaD0U0aS7CiErDPcK63Co1ZbtuvOeTNmBcp3ykBx3U7r68hSEKifrbJgwzvvRkL
         uV69cQH0WIlhBFA0N43wiFrFRnDPU/zEgHuKEbV01dq5Xpz5bFN9tlrpIol4NROfMc97
         YTgRFG2lgSrTVoD5H3PMfruLiv2z7XtMVtDm1kXmKl1Xp0MgMm3qkgxQM4ondNjYjVsK
         hddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790850605; x=1791455405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J3MX1SIOE23Q6Knq+G8g7lwc8PeLBc1oDxDbBbgHkhA=;
        b=ob8Z6yYQOHdVl9lD/6HA3mFJPt2fq2AzeD3HBj5BYSNqvHK/ZDJOaWKHfuu4BLCRjD
         qYPRKLcOXSv9HOl6W0nZdsPKU9+WZ3Jfjtfo4cheN1hP4kjfgmYZiqMlZtY8TKIYUrdC
         nRoefh8cIYfakvG1T3DXX3EBDFpfwKa2rWV4VM4bEhKBs3NaPgeMGO1WFBUVX6Q+l7l6
         M/wGRjE6VYlT8aH+HYEie5LIbkkorzvlqNVMtA3Oos5pIHvwu13keqZhhaVD/0giN2cf
         5th3SK2QTbMiwwurzY35iS+oJzN1b6Ydk34ClJXwfs6Wr9P1NdsqbPshRTJhjJjoNa7f
         pavg==
X-Forwarded-Encrypted: i=1; AKwUvBxBImRxdzejSav5LaS9BeTz0FJ9JOFRJv1a0JmFIdxDZdMPftyJQEdZfS+Sie7tSclUE7ldPj5leGuUU/lJ@vger.kernel.org
X-Gm-Message-State: AFq9FYK0fGHCqs4HRoriUFRE+QtUeFmDHw8gSl/sLRmyPz5HgqMcPy/k
	wG7zUbZybV4RW5yXvl4c4YzH17GTE7emZ2ZAchIzSgUmodQaV34q7L4r
X-Gm-Gg: AYBFou0/ICWIXVkIH7LtaANrXe6wlE40iOBLCG73JBfAxWm4aw70oyKpISrRT/L8P8E
	HUUoTVf5mauPJqQkC69aOaZycOKbLMUUDKtd8aadzQv3oRF+VaEW6JoPmx92gOHcdVgfmZiLvFU
	VR2jf78ou4rt22R7+apZ0+KXEQ4gg5lUAkGT361VAObM2Iy5wEILunQ28I/g2ny+RizEoNw0MUq
	K7cMPZugaktzKcHM7gdvZf0b47w6iCKZCdEW0E/mV8KZLJzIlA9DSgVIUfnlDycm3WkAzQh7mqO
	Tu77L3y1Z2kRvOc1eJTe4BXidRkzLnBOXssXwFNI2oavkcli1tQs7Qa4ZWOr+WvnJfu+Md4AqR6
	dG3XKIgE50DtpjtGlp6oA/ekGzfRRjgI47Gn1jyhOU7PyIRJyo3iqaH7q0KE7ElPOweCVzyDQXw
	WUIfPjiHbBN0hlkgMhNtMy+AgEcldQW2M9NrKiOoSZhd5ACgP5LQQgAgcYb1VtRsHzS+2l53oB/
	faaALDTjHsNAvZWcmaYFk0YXw5ERbFeIf1jt4ChyoxvlhYbfQZ98/NOGs1ewa9zRPPntOcsZySg
	bKnPIdStatTQ+tplRv3aObCOshuGh4txHlpB/jPE/OwUj3C5xx085b7uN74=
X-Received: by 2002:a17:903:120b:b0:2dd:c054:197e with SMTP id d9443c01a7336-2e2e4b48161mr33671215ad.35.1790850605188;
        Thu, 01 Oct 2026 03:30:05 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300b62f4esm8664475ad.73.2026.10.01.03.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 03:30:04 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Hui Peng <benquike@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: bound empty directory blocks in isofs_read_level3_size()
Date: Thu,  1 Oct 2026 18:30:00 +0800
Message-ID: <20261001103000.3408032-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xr6nxaat4f4zlmnk6dcn6fyiih336io2qaxm6lytxyb23oznw6@xcd4rjwpg4di>
References: <20260919222553.3792320-1-benquike@gmail.com> <20260923175215.1577791-1-matthias.goergens@gmail.com> <w3rnunloyshklgq4ocr4jsullzhaey6u7odstfoyhd4usbfppo@m33jyem5jgrf> <20260924151356.3287733-1-matthias.goergens@gmail.com> <20260925043804.2091174-1-matthias.goergens@gmail.com> <cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n> <20260926083517.556576-1-matthias.goergens@gmail.com> <cm3n7vjwbdnafttuz5ftkzz5wdbalgews4dfs5zlwvkyuzotuq@jo2nhsplhstc> <20260930033940.175021-1-matthias.goergens@gmail.com> <xr6nxaat4f4zlmnk6dcn6fyiih336io2qaxm6lytxyb23oznw6@xcd4rjwpg4di>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honza,

> Right, that needs a bit more care but still, something like the attached
> patch should work?

Yes, it does.  Testing the next-section link as "not yet set" instead
of "i == 1" is what was missing from the first variant.  I ran your
patch on top of v1, built in userspace with ASan and UBSan, against 67
test images: empty blocks between and after the section records,
three-section files, and the 100 bound from both sides.  i_size, the
recorded next section, the limit message and the file contents match
v1 on every image, including the split-gap one your first variant read
wrongly.  No sanitizer reports.

Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>

Thanks,
Matthias
