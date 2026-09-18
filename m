Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A8249739D;
	Fri, 18 Sep 2026 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733369; cv=none; b=MlvMy45+Jr0mIlmL43Ko/YyIdOvbw9Ygss1UxiYLQ/E/YdPDCHd41l5Y8hDQ+lXxwXUOuWQ3kK2MB3CnUbFo25PK8ZQMtAc6KZxfCnEhmUrUlM8RhjWXN4bVHeWSvTM0ciqu8pUtuVUSTCxNj7EVYcjAivUPXMZCmeQPzu+AHX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733369; c=relaxed/simple;
	bh=czk23+e2hQaKbTFSaBuofQ9W33Za6GwAKFjnRLTEs+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKUJoASSEWMXbSDhjQWbAyLWEVE4ZbWu1xEDh1XE2YfORabhGMI2uSOS2Cn3XB0TZ2NsJgeKvO8XqC4hOWg9ZKG1dfuYpioq9+0L0T/MAhXLCanTqNgV8AYwGkGVEkXE9Aq/fF+oW+6vqDEYjUeXmgyYcATvvvqu/t6J+L/M+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=U/ETbljm; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="U/ETbljm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=EyFsSkcm3oVE5Ugihsgv+e4vsyqxkIDHvVjlIpyeGu0=; b=U/ETbljm2dlG0K++MXk26LfurX
	J5IZUqwlQV0i8RfkwlkRFe/VazmreZpp+vklauGcDLFufglRj0jgm3s8btaYl/UuraQxhvPbpBdKP
	CuIL/L87pDBNj9j4h/5DDPxxFL047oQ8ISPNT8Mx4PD6JrxFyWylBSAMG9pirri6tejLVtCQRIVU3
	N6dk0mrlzDuHuhZmVnBOOSp8KYxioq8hKbwt/reW0z+Z1v/61jxcdHtx1RdyT5oOG1OcpVPhq0Xr9
	2qYgwRiFwh3VElfjHR5U8li04UcNNOuhdLuN+mE1rfj65q0PnJs9qgGXOXv89KArdZcOcE38YbSw3
	IpL9ya6npq0oJ9/D/GCC+zAlDTCxPXRSVRSOZ3R9XBcCmuLXIAnpnsa60VzwXkqBdbQ/HIU6qclCc
	N5Yp83+LUK6KSyrMkqIwJQgnPdFjDSjKXIjLN5UhlkrBdvLDJ1KUPCwdeR4FMjf8qKKwwsPz9gcV0
	T9BEvx0x5vVk1RmYF1fhYlUCgAGmz1vUiETlgVMFtBmoYkFqgRQnpVjbVudaamINBqZE5KBgm3bXp
	9x9KeaoR2xUUt2Bs+/YTNgH+3Jm10oz9ds/pugDPfbaA/AJf84FOMP0rP031qRUJHZZZkTuInJR+B
	MU+7c4mFpzxny1Z+draGypE/1w4JoFVWwe6+ZE/oM=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v7 0/4] 9p: Performance improvements for build workloads
Date: Fri, 18 Sep 2026 14:09:23 +0200
Message-ID: <23246408.EfDdHjke4D@weasel>
In-Reply-To: <cover.1779355927.git.repk@triplefau.lt>
References: <cover.1779355927.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 21 May 2026 11:40:28 CEST Remi Pommarel wrote:
> This patchset introduces several performance optimizations for the 9p
> filesystem when used with cache=loose option (exclusive or read only
> mounts). These improvements particularly target workloads with frequent
> lookups of non-existent paths and repeated symlink resolutions.
> 
> The very state of the art benchmark consisting of cloning a fresh
> hostap repository and building hostapd and wpa_supplicant for hwsim
> tests (cd tests/hwsim; time ./build.sh) in a VM running on a 9pfs rootfs
> (with trans=virtio,cache=loose options) has been used to test those
> optimizations impact.
> 
> For reference, the build takes 0m56.492s on my laptop natively while it
> completes in 2m18.702sec on the VM. This represents a significant
> performance penalty considering running the same build on a VM using a
> virtiofs rootfs (with "--cache always" virtiofsd option) takes around
> 1m32.141s. This patchset aims to bring the 9pfs build time close to
> that of virtiofs, rather than the native host time, as a realistic
> expectation.
> 
> This first three patches in this series focus on keeping negative
> dentries in the cache, ensuring that subsequent lookups for paths known
> to not exist do not require redundant 9P RPC calls. This optimization
> reduces the time needed for the compiler to search for header files
> across known locations. The two first patches introduce a new mount
> option, ndentrycache, which specifies the number of ms to keep the
> dentry in the cache. Using ndentrycache without value (i.e. keeping the
> negative dentry indifinetly) shrunk build time to 1m46.198s. The third
> patch enable the negative dentry caching for 24 hours by default on
> cache=loose.
> 
> The fourth patch extends page cache usage to symlinks by allowing
> p9_client_readlink() results to be cached. Resolving symlink is
> apparently something done quite frequently during the build process and
> avoiding the cost of a 9P RPC call round trip for already known symlinks
> helps reduce the build time to 1m26.602s, outperforming the virtiofs
> setup.
> 
> Here is summary of the different hostapd/wpa_supplicant build times:
> 
>   - Baseline (no patch): 2m18.702s
>   - negative dentry caching (patches 1-3): 1m46.198s (23% improvement)
>   - Above + symlink caching (patches 1-4): 1m26.302s (an additional 18%
>     improvement, 37% in total)
> 
> With this ~37% performance gain, 9pfs with cache=loose can compete with
> virtiofs for (at least) this specific scenario. Although this benchmark
> is not the most typical, I do think that these caching optimizations
> could benefit a wide range of other workflows as well.

Just for the records: this series has been merged via 1bc18858358d (Sun Jun 21 
2026, merge tag '9p-for-7.2-rc1').

/Christian



