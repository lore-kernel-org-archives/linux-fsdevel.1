Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C642360ECD;
	Thu, 23 Jul 2026 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794281; cv=none; b=YVwbxxg/eynCTon4BhwNFby+1SYed5adqB2TWNCDPKDg/o8Cah10LD+sYKguOx86YctNv73PBItOGjUVvHb4gQGTARa0og6YLHw1GsJec42fWf0VplQ0wUL7ixtYf1ndIBWB3rYchTwrpns9jl1ukYjDRNPwdpbjwyZY93g8DcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794281; c=relaxed/simple;
	bh=K3PUyr0DEP8VGJJIe0b4T0sl2UgO5puTOVJ0th5o4nE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=it3Tsixh5exSLx0rfWd+HmCxty6rq18KRb2SNm+LidtK1WMJzLeZ8lRjDUl3C+W8UvIZk0fsbwt3vBmmIXISt6T+jW0e7lrrnji/nq1AYqcbac2YNLfVK1qYLXCmqcNdTCTYfby663ttsnDwtUenKjjFDT5sQyfik8LNVz4wY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTM5s47N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTM5s47N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C123B1F000E9;
	Thu, 23 Jul 2026 08:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784794280;
	bh=i4RVvoFi0Dyy96ER3LViTHlLmxqPiXuHWpallRWipko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WTM5s47NxXCBG1c2bxsI+c429M17rqzaeOLfRpQUjzYUuRTkEzLtrvM0CbqRtFSa3
	 N9OSSliYe11eypHg3gr+cgytONOqzH+P09+jhCwmOdHS5hKIi1MXEmYY9feyV1NXD2
	 +ZPMCSrswzohn2Zl9fqua2lhNTj2qGlPMbZwxlxJ4a4ZuyA3toVPTMyvAWbG6EMMPf
	 rLiZyo39aim5aPk97vQiUU+PXnZhFnBsB3vn9a7XN0q+SZo0KTdgIcOFXjr4psqhUo
	 tcluZVK5uO1V9tMXTKi7n5swLujjFMhNAJmlFMdlLqqaeon/UA7M28kfYuATHIlnCE
	 fqPgetVOvv0nw==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, jack@suse.cz, 
 Chen Changcheng <chenchangcheng@kylinos.cn>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ccc194101@163.com
In-Reply-To: <20260721064140.152305-1-chenchangcheng@kylinos.cn>
References: <20260721064140.152305-1-chenchangcheng@kylinos.cn>
Subject: Re: [PATCH] fs/super: fix emergency thaw double-unlock of s_umount
Message-Id: <20260723-lobgesang-errichten-zunge-ed7f456425f1@brauner>
Date: Thu, 23 Jul 2026 10:11:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-35fdc
X-Developer-Signature: v=1; a=openpgp-sha256; l=887; i=brauner@kernel.org;
 h=from:subject:message-id; bh=K3PUyr0DEP8VGJJIe0b4T0sl2UgO5puTOVJ0th5o4nE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlnlmW0vOn1t1oFatU4s2ew+6TbPtjlxsrPChq8fG9F
 aLdE93YUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGVsgx/5Xd/S3qpceqsveK9
 IzsUnE7mH/2a91pHdZ1vL4f6/DVRdxn+V7Lm24cYmp3/8JLfsf/2vC5hQYumA0t3WAt/bTFhd8l
 jBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 21 Jul 2026 14:41:40 +0800, Chen Changcheng wrote:
> fs/super: fix emergency thaw double-unlock of s_umount

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs/super: fix emergency thaw double-unlock of s_umount
      https://git.kernel.org/vfs/vfs/c/02947315728e

