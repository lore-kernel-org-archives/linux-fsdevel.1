Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA023195F0;
	Mon,  6 Jul 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343452; cv=none; b=EHhA1TLmKA/IVmekXJtVtuMvPz3tH7lAVfnfV+UkrB6uBIOeGnZck9cJMLS8uCeG4eNfUA4JLRYrAEvr1WgO5yH2A+Ha2rQKlsHFQiss4o5eRY9XOSt1wsagylXHP4V100FSj/mrfWb/pY498J+2pWJkeNB0dxVXQWqZ5g7mRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343452; c=relaxed/simple;
	bh=ytSrnTtr4aIAO2OhrWsTRaPCpNrjmfDfgUG+YwjRQtY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=DSYgh4ytmez50Fp2UAK9l1gDlgm1yac/iUKNBcOGt4XvQhe2sbpmuetVSt+4CnG4q8YDp60tgq9udmcNH9bY3y0/a78Q1hf3A0Afqb9zk8bsOFWBuox03HVU85cxJ6g2ML4R9ZX9O/0Gm/uckeoP17Eo9ozEu/qV3bbWsgA7M38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJQvho02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJQvho02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C1F1F000E9;
	Mon,  6 Jul 2026 13:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783343450;
	bh=g+/i897jKV1Cz7z8W/Ec4pmFqifYObGSuALXFAn9X7w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=CJQvho02gFoLFNJ1hv35adHVQWH6ClDq+uGFuXCRI1Hs4wR4MvXAeO2NZIQgCYmD/
	 Dbb377XFCcBZHoh97PPVgvAVu/qKI9sRo+U0+RbIRjmDXRVrznfb7f4W1ZD6BPFpeM
	 rWyQ2Yhmo7/ijewjwPD3d37+VOM0SCdb4n2RikEMQZ85N7NEBcmJnLsCCazPBGIjE+
	 YR5hIk61CzvcW5dnL4P71IrYZI/EO21CSsSR//u85HRLpmlDuzsCFaPX1J0MTLHDWo
	 kIE8I6IJCP/eefp1rw/4tL2CUBckh+vnVbKPo/q9jM3G7zuuY3bn9PqBhEV2YoX9x6
	 R9BqWnnKh5TPQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] selftests/filesystems: fix missing and stale TARGETS
 entries
From: Christian Brauner <brauner@kernel.org>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: shuah@kernel.org, wenyang.linux@foxmail.com, akpm@linux-foundation.org, 
 jlayton@kernel.org, brauner@kernel.org, jack@suse.cz, djwong@kernel.org, 
 aleksa@amutable.com, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260703150742.58991-1-disgoel@linux.ibm.com>
References: <20260703150742.58991-1-disgoel@linux.ibm.com>
Date: Mon, 06 Jul 2026 15:10:45 +0200
Message-Id: <20260706-geerntet-neonlicht-liege-d005ee1904b3@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=885; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ytSrnTtr4aIAO2OhrWsTRaPCpNrjmfDfgUG+YwjRQtY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR5r4wQ42x1dGlZ6r8xc9sZlTdLhd+1BR/Ky3m5w/M/R
 5HmlL9RHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5coCR4d7jC8Ea+t/yv6Wv
 tp30MOLu+zkyJl/53eYq7rA9sunZ1xKGf2bxz6daHrr/U/1eY+dux10iJZqeZit+zuh2PW5SHB5
 7igUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> filesystems/eventfd, filesystems/open_tree_ns and filesystems/xattr
> were never added to TARGETS when introduced. filesystems/openat2 was
> moved from selftests/openat2/ but the TARGETS entry was never updated,
> leaving a stale entry pointing at a directory that no longer exists.
> 
> Fix this by adding the four missing subdirectories to TARGETS and
> removing the stale openat2 entry.
> 
> Fixes: 7c37857fc23a ("selftests: add eventfd selftests")
> Fixes: b8f7622aa6e3 ("selftests/open_tree: add OPEN_TREE_NAMESPACE tests")
> Fixes: 7e28fef5d4db ("selftests/xattr: path-based AF_UNIX socket xattr tests")
> Fixes: fe087927046c ("selftests: move openat2 tests to selftests/filesystems/")
> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>

Seems fine,
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

-- 
Christian Brauner <brauner@kernel.org>
