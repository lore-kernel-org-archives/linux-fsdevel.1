Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD46B3C09E0
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404714; cv=none; b=lO6lfq1jckBi39QFMqu3ioaxSOsJdpY9t1OQ/XdBdfKxOaCXhDz/c/sXMtyInubSHptirVGRIxHSa3Lhn+flceP8gFsqAv5VxC9zuO3rrE+FxYPBQ0oAmXv/TCYSpXIM/9MmdXfCNfw/AI3lUCZY9c1GCwGTuJzCEKmEYRtb3WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404714; c=relaxed/simple;
	bh=jlQoa5SFA5X6pn/MrSivvi449RxWG8OdfPmVva4MvNo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=AVsj+CILdCbKMCdyw0j2W0hVAdUZS0zKRBboPXC78A7hOWVgw9w2S19NW7UZ4HX3F4ANGcLCp0fZ6q3njbdWVIjFoZJQvWPX0DaaHs6LaD9ZclK7KN+eGKBlo5YYmu8XW/2F9nbfaXZMyv9Yp26DR8U/TUZDgUrIXedhPjlptvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dln0HoAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dln0HoAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A6E1F000E9;
	Thu, 30 Jul 2026 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785404713;
	bh=0lfLA369TUu0P4YVdcb2+35w4wWIyfEzp88ExDkoXt8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=dln0HoAD0MLxF+F/bLL0ALyx58jCYdu5BF9IkoewlwJtHcG3x99YjBhKx6cIiv8mj
	 IQJ67bGpL0rYg012BknHdLFDbKPkLY/cX5yHlXVPbf6s/pCnIRzeywOlKn031N3vI/
	 3X+uEmImP0VAX2UQo5Xqq4wPty2FVxOVqlD6QUFRnWkatVoFGkKLyqjdiAv+Iprm8O
	 F7WQsrI7y++manrUNDw+Gk7Q8zxwdY+jq4DBNjoMDd4fgIqzBC1pB78x1rlp7kMh0V
	 gxCpxECoz/H0nfY61en/mLP1BEnl4RCOtMe7xEB2693hQSIp+w4IjlXR/Jn8adZ2HM
	 D3lAt7sYV8zHw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5] erofs: accept source file descriptor via fsconfig
From: Christian Brauner <brauner@kernel.org>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, cyphar@cyphar.com, 
 hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260728160619.853924-1-gscrivan@redhat.com>
References: <20260728160619.853924-1-gscrivan@redhat.com>
Date: Thu, 30 Jul 2026 11:45:08 +0200
Message-Id: <20260730-krisenfest-hunger-anspannung-acbe386967b0@brauner>
X-Mailer: b4 0.16-dev-3e0c3
X-Developer-Signature: v=1; a=openpgp-sha256; l=386; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jlQoa5SFA5X6pn/MrSivvi449RxWG8OdfPmVva4MvNo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRly2oYX53jXrS06tDMiCdH3tqd3li17abe/BU9kVrTT
 0U5vIow7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIGSMjQ9/pn8tv+ZZM/5di
 el+3zmvjLuONzPbicYlSc0QuyHXNPcvI8OpP36dnP1J8Gx7w1DycnF5aKPB3b3P7bEWXebvEYpl
 3sQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hi Giuseppe,

> Allow userspace to pass an already-opened file descriptor as the mount
> source instead of a path string.  This is useful for tools that already
> hold an fd to the image, such as composefs reusing an existing erofs
> backing file.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Acked-by: Christian Brauner (Amutable) <brauner@kernel.org>

-- 

