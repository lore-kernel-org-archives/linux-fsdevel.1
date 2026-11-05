Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915777;
	b=O03WTrDIDI4fUdyhqie9mCXu7V0TzKZGZwV8dXjYvKl6rBWn8/gii3EXuz9CHU/jYkJq
	 KfTgimuf4MZmVbBGKdx7tttuZPiZhnzVHONcNeQdbup68sbBcK5L/lUFi3Ibs1Rwyh/Xh
	 YpunqB/AhsjQU9QLxPyMSL9BxpuFGbLUV7y16YRale0TgAAIew22AlDOIZSgZ/sVPkToI
	 J7JDu2Jc9boH4tQn9SxU+9bl695uOPvLGQ0QVHfmWB37v9LaGeOB6WCxDdMqvG06wxMQb
	 b0CjyjQsoOtYGI8PS4LTzC56nStVYExWupX9hWs8b2hLUxrBJU7V/+iq3RZtX6G9H5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915777;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=vywGW/w9A5Xb0PLmEISAg1jPIL5zwhJ5ig1Oi5SXK+Y=;
	b=RMelABaWkecYmY0AknUBjgfw4t86RfhB5IarIfv8jAx8MXy9OvtM6VblxeqJvC89oFA6
	 GgjxhSJQhH6PShnVPJgvO9HPcrYnGVm5D3Q+T0Cpo3+LYIbvG+NNdy+394xzYtStIqnj+
	 7PHAZgInaffEPzq0372qNfW1vFoSpZ/THwuRJhRuV2W/JURC1/7OPikvhE5xQgvQfMkeb
	 2tB0Ees6E0WoZjnf5ESEAbTgNx6+iquhFVmLEVsG5akICVmGOtlZwyxMdLepDeG/281LL
	 RKhOLxhwPjYWY0ImaT+B82oZkLisiOIgdeTDYAWWJIgfoXJzRTJRfdVd2bhxhCghusg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcNMStNT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87B9606A329;
	Thu,  5 Nov 2026 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcNMStNT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272621F0089F;
	Thu,  5 Nov 2026 21:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915776;
	bh=vywGW/w9A5Xb0PLmEISAg1jPIL5zwhJ5ig1Oi5SXK+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kcNMStNT68FoGT5uh623VKVsg++HdFfNjazQhdXLvijdfn/vdANjtO0Uwaq0ukoQL
	 YeuH8OKfqzjaOguBfDDTMP1D8KpHwonuUusvwojVgtibsPYJ1I00f2TL3FNDAjKoGV
	 vCSkASBYCs7t35V31ghiLU51Lg7gBJKCL/RXK+lSq6Meig9ArEjHcE0WcVWv8IqADQ
	 KRLDyVgrY1TfE2a108u1vsdSMrLUX7eonPTjfblyD3E0X2iMc0cnsyprGRBnK9kQml
	 VzJkyS/iEkIUR1CTS7a+hHRXmee7Pt1FO85F5zWRcYmYmspGMTLHy4XG/B9HaJI4/S
	 BQsVSwNPfMINA==
From: Christian Brauner <brauner@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261103155508.535010-1-sashal@kernel.org>
References: <20261103155508.535010-1-sashal@kernel.org>
Subject: Re: [PATCH] selftests/statmount: fix format warnings on 32-bit and
 s390
Message-Id: <20261105-gemildert-gepfiffen-amtsmissbrauch-ac53887498e1@brauner>
Date: Thu, 05 Nov 2026 22:56:13 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-ce4c1

On Tue, 03 Nov 2026 10:55:08 -0500, Sasha Levin wrote:
> The f_type field of struct statfs is an int on i386 and armhf and an
> unsigned int on s390x, and the listmount() results are uint64_t, so
> printing them with %lx and %zi warns:
> 
>   statmount_test_ns.c:243:56: warning: format '%zi' expects argument of type 'signed size_t', but argument 2 has type 'uint64_t' {aka 'long long unsigned int'} [-Wformat=]
> 
> Cast f_type to unsigned long, and print the listmount() results as
> unsigned long long.
> 
> [...]

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

[1/1] selftests/statmount: fix format warnings on 32-bit and s390
      https://git.kernel.org/vfs/vfs/c/de48f2a93e4f

